
if exists('g:loaded_vim_etherpad') || &cp
  finish
endif
let g:loaded_vim_etherpad = 1

hi EpadAttrBold      term=bold      gui=bold
hi EpadAttrItalic    term=italic    gui=italic
hi EpadAttrUnderline term=underline gui=underline
hi EpadAttrStrike    term=reverse   gui=reverse

hi def link EpadBold      EpadAttrBold
hi def link EpadItalic    EpadAttrItalic
hi def link EpadUnderline EpadAttrUnderline
hi def link EpadStrike    EpadAttrStrike

let g:epad_pad = "test"
let g:epad_host = "localhost"
let g:epad_port = "9001"
let g:epad_path = "p/"
let g:epad_verbose = 0 " set to 1 for low verbosity, 2 for debug verbosity
let g:epad_updatetime = 1000

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

def calculate_fg(bg):
    # http://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
    if bg.startswith('#'):
        r, g, b = (int(bg[1:3], 16), int(bg[3:5], 16), int(bg[5:-1], 16))
        if (r*0.299+b*0.587+g*0.114) > 50:
            return "#000000"
    return "#ffffff"


def _update_buffer():
    """
    This function is polled by vim to updated its current buffer
    """
    if pyepad_env['updated']:
        text_obj = pyepad_env['text']
        text_str = pyepad_env['text'].decorated(style=Style.STYLES['Raw']())
        vim.current.buffer[:] = [l.encode('utf-8') for l in text_str.splitlines()]
        c, l = (1, 1)
        for i in range(0,len(pyepad_env['colors'])):
            vim.command('syn clear EpadAuthor%d' % i)
            vim.command('hi clear EpadColorAuthor%d' % i)
        for i in range(0, len(text_obj)):
            color = text_obj.get_author_color(i)
            if color:
                if not color in pyepad_env['colors']:
                    pyepad_env['colors'].append(color)
                color_idx = pyepad_env['colors'].index(color)
                vim.command('hi EpadColorAuthor%d  guibg=%s guifg=%s' % (color_idx, color, calculate_fg(color)))
                vim.command('hi def link EpadAuthor%d  EpadColorAuthor%d' % (color_idx, color_idx))
                vim.command('syn match EpadAuthor'+str(color_idx)+' /\%'+str(l)+'l\%'+str(c)+'c./')
            c += 1
            if text_obj.get_char(i) == '\n':
                l += 1
                c = 1
        vim.command('redraw!')
        pyepad_env['updated'] = False

def _launch_epad(padid=None, host=None, port=None, path=None, verbose=None, *args):
    """
    launches EtherpadLiteClient
    """
    if not padid:
        padid = vim.eval('g:epad_pad')
    if not host:
        host = vim.eval('g:epad_host')
    if not port:
        port = vim.eval('g:epad_port')
    if not path:
        path = vim.eval('g:epad_path')
    if not verbose:
        verbose = vim.eval('g:epad_verbose')
    verbose = int(verbose)

    if verbose:
        logging.basicConfig()
        if verbose is 1:
            logging.root.setLevel(logging.INFO)
        elif verbose is 2:
            logging.root.setLevel(logging.DEBUG)

    # disable cursorcolumn and cursorline that interferes with syntax
    vim.command('set nocursorcolumn')
    vim.command('set nocursorline')
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

    try:
        pyepad_env['epad'] = EtherpadIO(padid, vim_link, host, path, port, verbose, 
                                        transports=['websocket', 'xhr-polling'], 
                                        disc_cb=on_disconnect)

        if not pyepad_env['epad'].has_ended():
            vim.command('echomsg "connected to Etherpad: http://%s:%s/%s%s"' % (host, port, path, padid))
        else:
            vim.command('echoerr "not connected to Etherpad"')

    except Exception, err:
        vim.command('echoerr "Couldn\'t connect to Etherpad: http://%s:%s/%s%s"' % (host, port, path, padid))

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

EOS

command! -nargs=* Etherpad :python _launch_epad(<f-args>)
command! -nargs=* EtherpadStop :python _stop_epad(<f-args>)
command! -nargs=* EtherpadPause :python _pause_epad(<f-args>)
command! -nargs=* EtherpadUpdate :python _vim_to_epad_update(<f-args>)


