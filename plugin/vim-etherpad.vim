
if exists('g:loaded_vim_etherpad') || &cp
  finish
endif
let g:loaded_vim_etherpad = 1

let g:epad_pad = "test"
let g:epad_host = "localhost"
let g:epad_port = "9001"
let g:epad_path = "p/"
let g:epad_verbose = 0 " set to 1 for low verbosity, 2 for debug verbosity
let g:epad_attributes = 1 " set to 1 for showing attributes
let g:epad_updatetime = 200

autocmd CursorHold * call Timer()
function! Timer()
  call feedkeys("f\e")
  " K_IGNORE keycode does not work after version 7.2.025)
  " there are numerous other keysequences that you can use
  py _update_buffer()
endfunction

python << EOS
import difflib
import logging
import vim
import sys
import os

path = os.path.dirname(vim.eval('expand("<sfile>")'))

try:
    from socketIO_client import SocketIO
    from py_etherpad import EtherpadIO, Style
except ImportError:
    sys.path += [os.path.join(path, "../pylibs/socketIO-client/"), 
                 os.path.join(path, "../pylibs/PyEtherpadLite/src/")]
    from socketIO_client import SocketIO
    from py_etherpad import EtherpadIO, Style

pyepad_env = {'epad': None,
              'text': None,
              'updated': False,
              'updatetime': 0,
              'colors': []}

attr_trans = {'bold':          'bold',
              'italic':        'italic',
              'underline':     'underline',
              'strikethrough': 'undercurl'}

def calculate_fg(bg):
    # http://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
    if bg.startswith('#'):
        r, g, b = (int(bg[1:3], 16), int(bg[3:5], 16), int(bg[5:-1], 16))
        if (r*0.299+b*0.587+g*0.114) > 50:
            return "#000000"
    return "#ffffff"

def calculate_bright(color):
    if color.startswith('#'):
        r, g, b =  (int(color[1:3], 16)+32, int(color[3:5], 16)+32, int(color[5:], 16)+32)
        if r > 255: r = 0xff
        if g > 255: g = 0xff
        if b > 255: b = 0xff
        return "#%02x%02x%02x" % (r, g, b)
    return "#000000"
        

def _update_buffer():
    """
    This function is polled by vim to updated its current buffer
    """
    if pyepad_env['updated']:
        text_obj = pyepad_env['text']
        text_str = pyepad_env['text'].decorated(style=Style.STYLES['Raw']())
        vim.current.buffer[:] = [l.encode('utf-8') for l in text_str.splitlines()]
        c, l = (1, 1)
        for hilight in pyepad_env['colors']:
            vim.command('syn clear %s' % hilight)
        for i in range(0, len(text_obj)):
            attr = text_obj.get_attr(i)
            color = text_obj.get_author_color(i)
            cursor = text_obj.get_cursor(c-1, l-1)
            if color:
                # because colors can't be combined, here is a workaround,
                # see http://stackoverflow.com/questions/15974439/superpose-two-vim-syntax-matches-on-the-same-character
                if len(attr) > 0 and vim.eval('g:epad_attributes') != "0":
                    vimattr = map(lambda x: x[0], sorted(attr))
                    colorname = "Epad"+ color[1:] + "_" + reduce(lambda x, y: x+y.capitalize(), vimattr)
                    vimattr = ",".join([attr_trans[attr] for attr in vimattr])
                    if cursor:
                        cursorcolor = text_obj._authors.get_color(cursor)
                        cursorcolor = calculate_bright(cursorcolor)
                        cursorname = "Epad"+ cursorcolor[:]
                        pyepad_env['colors'].append(cursorname)
                        vim.command('hi %(cname)s guibg=%(bg)s '\
                                    'guifg=%(fg)s ' % dict(cname=cursorname, 
                                                           fg=calculate_fg(cursorcolor),
                                                           bg=cursorcolor))
                    if not colorname in pyepad_env['colors']:
                        pyepad_env['colors'].append(colorname)
                        vim.command('hi %(cname)s guibg=%(bg)s '\
                                    'guifg=%(fg)s gui=%(attr)s '\
                                    'term=%(attr)s' % dict(cname=colorname, 
                                                           fg=calculate_fg(color),
                                                           bg=color,
                                                           attr=vimattr))
                else:
                    colorname = "Epad"+ color[1:]
                    if not colorname in pyepad_env['colors']:
                        pyepad_env['colors'].append(colorname)
                        vim.command('hi %(cname)s guibg=%(bg)s '\
                                     'guifg=%(fg)s' % dict(cname=colorname, 
                                                           fg=calculate_fg(color),
                                                           bg=color))
                if cursor:
                    vim.command('syn match %s ' % (cursorname,)
                                +'/\%'+str(l)+'l\%'+str(c)+'c./')
                else:
                    vim.command('syn match %s ' % (colorname,)
                                +'/\%'+str(l)+'l\%'+str(c)+'c./')
            c += 1
            if text_obj.get_char(i) == '\n':
                l += 1
                c = 1
        vim.command('redraw!')
        pyepad_env['updated'] = False

def _launch_epad(padid=None, verbose=None, *args):
    """
    launches EtherpadLiteClient
    """
    def parse_args(padid):
        protocol, padid = padid.split('://')
        secure = False
        port = "80"
        if protocol == "https":
            secure = True
            port = "443"
        padid = padid.split('/')
        host = padid[0]
        if ':' in host:
            host, port = host.split(':')
        path = ""
        if len(padid) > 2:
            path = "/".join(padid[1:-1])+'/'
        padid = padid[-1]
        return secure, host, port, path, padid

    host = vim.eval('g:epad_host')
    port = vim.eval('g:epad_port')
    path = vim.eval('g:epad_path')
    secure = False
    if padid:
        if not padid.startswith('http'):
            padid = padid
        else:
            secure, host, port, path, padid = parse_args(padid)
    else:
        padid = vim.eval('g:epad_pad')

    if not verbose:
        verbose = vim.eval('g:epad_verbose')
    verbose = int(verbose)

    logging.basicConfig()
    if verbose:
        if verbose is 1:
            logging.root.setLevel(logging.INFO)
        elif verbose is 2:
            logging.root.setLevel(logging.DEBUG)
        else:
            logging.root.setLevel(logging.WARN)
    else:
        logging.root.setLevel(logging.WARN)

    # disable cursorcolumn and cursorline that interferes with syntax
    vim.command('set nocursorcolumn')
    vim.command('set nocursorline')
    pyepad_env['buftype'] = vim.eval('&buftype')
    vim.command('set buftype=nofile')
    pyepad_env['updatetime'] = vim.eval('&updatetime')
    vim.command('set updatetime='+vim.eval('g:epad_updatetime'))

    def vim_link(text):
        """
        callback function that is called by EtherpadLiteClient
        it stores the last updated text
        """
        if not text is None:
            pyepad_env['text'] = text
            pyepad_env['updated'] = True

    def on_disconnect():
        """
        callback function that is called by EtherpadLiteClient 
        on disconnection of the Etherpad Lite Server
        """
        vim.command('echoerr "disconnected from Etherpad"')
        vim.command('set updatetime='+pyepad_env['updatetime'])
        vim.command('set buftype='+pyepad_env['buftype'])

    try:
        pyepad_env['epad'] = EtherpadIO(padid, vim_link, host, path, port, 
                                        secure, verbose, 
                                        transports=['websocket', 'xhr-polling'], 
                                        disc_cb=on_disconnect)

        if not pyepad_env['epad'].has_ended():
            vim.command('echomsg "connected to Etherpad: %s://%s:%s/%s%s"' % ('https' if secure else 'http', host, port, path, padid))
        else:
            vim.command('echoerr "not connected to Etherpad"')

    except Exception, err:
        vim.command('echoerr "Couldn\'t connect to Etherpad: %s://%s:%s/%s%s"' % ('https' if secure else 'http', host, port, path, padid))

def _pause_epad():
    """
    Function that pauses EtherpadLiteClient
    """
    if not pyepad_env['epad'].has_ended():
        pyepad_env['epad'].pause()
    else:
        vim.command('echoerr "not connected to Etherpad"')

def _vim_to_epad_update():
    """
    Function that sends all buffers updates to the EtherpadLite server
    """
    if not pyepad_env['epad'].has_ended():
        pyepad_env['epad'].patch_text(pyepad_env['text'], "\n".join(vim.current.buffer[:]))
    else:
        vim.command('echoerr "not connected to Etherpad"')


def _stop_epad(*args):
    """
    Function that disconnects EtherpadLiteClient from the server
    """
    if pyepad_env['epad'] and not pyepad_env['epad'].has_ended():
        pyepad_env['epad'].stop()

def _toggle_attributes(*args):
    if len(args) > 0:
        if args[0] == "0":
            vim.command('let g:epad_attributes = 0')
        else:
            vim.command('let g:epad_attributes = 1')
    elif vim.eval('g:epad_attributes') == "0":
        vim.command('let g:epad_attributes = 1')
    else:
        vim.command('let g:epad_attributes = 0')
    pyepad_env['updated'] = True

EOS

command! -nargs=* Etherpad :python _launch_epad(<f-args>)
command! -nargs=* EtherpadStop :python _stop_epad(<f-args>)
command! -nargs=* EtherpadPause :python _pause_epad(<f-args>)
command! -nargs=* EtherpadUpdate :python _vim_to_epad_update(<f-args>)
command! -nargs=* EtherpadShowAttributes :python _toggle_attributes(<f-args>)


