
if exists('g:loaded_vim_etherpad') || &cp
  finish
endif
let g:loaded_vim_etherpad = 1

hi EpadAttrBold      term=bold      gui=bold
hi EpadAttrItalic    term=italic    gui=italic
hi EpadAttrUnderline term=underline gui=underline
hi EpadAttrStrike    term=reverse   gui=reverse

hi EpadColorAuthor0  guibg=#ffc7c7 guifg=#000000 ctermbg=DarkBlue
hi EpadColorAuthor1  guibg=#fff1c7 guifg=#000000 ctermbg=DarkGreen
hi EpadColorAuthor2  guibg=#e3ffc7 guifg=#000000 ctermbg=DarkCyan
hi EpadColorAuthor3  guibg=#c7ffd5 guifg=#000000 ctermbg=DarkRed
hi EpadColorAuthor4  guibg=#c7ffff guifg=#000000 ctermbg=DarkMagenta
hi EpadColorAuthor5  guibg=#c7d5ff guifg=#000000 ctermbg=DarkYellow
hi EpadColorAuthor6  guibg=#e3c7ff guifg=#000000 ctermbg=DarkGrey
hi EpadColorAuthor7  guibg=#ffc7f1 guifg=#000000 ctermbg=Grey    ctermfg=Black
hi EpadColorAuthor8  guibg=#ff8f8f guifg=#000000 ctermbg=Blue    ctermfg=Black
hi EpadColorAuthor9 guibg=#ffe38f guifg=#000000 ctermbg=Green   ctermfg=Black
hi EpadColorAuthor10 guibg=#c7ff8f guifg=#000000 ctermbg=Cyan    ctermfg=Black
hi EpadColorAuthor11 guibg=#8fffab guifg=#000000 ctermbg=Red     ctermfg=Black
hi EpadColorAuthor12 guibg=#8fffff guifg=#000000 ctermbg=Magenta ctermfg=Black
hi EpadColorAuthor13 guibg=#8fabff guifg=#000000 ctermbg=Yellow  ctermfg=Black
hi EpadColorAuthor14 guibg=#c78fff guifg=#000000 ctermbg=White   ctermfg=Black
hi EpadColorAuthor15 guibg=#ff8fe3 guifg=#000000 
hi EpadColorAuthor16 guibg=#d97979 guifg=#000000 
hi EpadColorAuthor17 guibg=#d9c179 guifg=#000000 
hi EpadColorAuthor18 guibg=#a9d979 guifg=#000000
hi EpadColorAuthor19 guibg=#79d991 guifg=#000000
hi EpadColorAuthor20 guibg=#79d9d9 guifg=#000000
hi EpadColorAuthor21 guibg=#7991d9 guifg=#000000
hi EpadColorAuthor22 guibg=#a979d9 guifg=#000000
hi EpadColorAuthor23 guibg=#d979c1 guifg=#000000
hi EpadColorAuthor24 guibg=#d9a9a9 guifg=#000000
hi EpadColorAuthor25 guibg=#d9cda9 guifg=#000000
hi EpadColorAuthor26 guibg=#c1d9a9 guifg=#000000
hi EpadColorAuthor27 guibg=#a9d9b5 guifg=#000000
hi EpadColorAuthor28 guibg=#a9d9d9 guifg=#000000
hi EpadColorAuthor29 guibg=#a9b5d9 guifg=#000000
hi EpadColorAuthor30 guibg=#c1a9d9 guifg=#000000
hi EpadColorAuthor31 guibg=#d9a9cd guifg=#000000
hi EpadColorAuthor32 guibg=#4c9c82 guifg=#000000
hi EpadColorAuthor33 guibg=#12d1ad guifg=#000000
hi EpadColorAuthor34 guibg=#2d8e80 guifg=#000000
hi EpadColorAuthor35 guibg=#7485c3 guifg=#000000
hi EpadColorAuthor36 guibg=#a091c7 guifg=#000000
hi EpadColorAuthor37 guibg=#3185ab guifg=#000000
hi EpadColorAuthor38 guibg=#6818b4 guifg=#ffffff
hi EpadColorAuthor39 guibg=#e6e76d guifg=#000000
hi EpadColorAuthor40 guibg=#a42c64 guifg=#000000
hi EpadColorAuthor41 guibg=#f386e5 guifg=#000000
hi EpadColorAuthor42 guibg=#4ecc0c guifg=#000000
hi EpadColorAuthor43 guibg=#c0c236 guifg=#000000
hi EpadColorAuthor44 guibg=#693224 guifg=#000000
hi EpadColorAuthor45 guibg=#b5de6a guifg=#000000
hi EpadColorAuthor46 guibg=#9b88fd guifg=#000000
hi EpadColorAuthor47 guibg=#358f9b guifg=#000000
hi EpadColorAuthor48 guibg=#496d2f guifg=#000000
hi EpadColorAuthor49 guibg=#e267fe guifg=#000000
hi EpadColorAuthor50 guibg=#d23056 guifg=#000000
hi EpadColorAuthor51 guibg=#1a1a64 guifg=#ffffff
hi EpadColorAuthor52 guibg=#5aa335 guifg=#000000
hi EpadColorAuthor53 guibg=#d722bb guifg=#000000
hi EpadColorAuthor54 guibg=#86dc6c guifg=#000000
hi EpadColorAuthor55 guibg=#b5a714 guifg=#000000
hi EpadColorAuthor56 guibg=#955b6a guifg=#000000
hi EpadColorAuthor57 guibg=#9f2985 guifg=#000000
hi EpadColorAuthor58 guibg=#4b81c8 guifg=#000000
hi EpadColorAuthor59 guibg=#3d6a5b guifg=#000000
hi EpadColorAuthor60 guibg=#434e16 guifg=#000000
hi EpadColorAuthor61 guibg=#d16084 guifg=#000000
hi EpadColorAuthor62 guibg=#af6a0e guifg=#000000
hi EpadColorAuthor63 guibg=#8c8bd8 guifg=#000000

hi def link EpadBold      EpadAttrBold
hi def link EpadItalic    EpadAttrItalic
hi def link EpadUnderline EpadAttrUnderline
hi def link EpadStrike    EpadAttrStrike

hi def link EpadAuthor0  EpadColorAuthor0 
hi def link EpadAuthor1  EpadColorAuthor1 
hi def link EpadAuthor2  EpadColorAuthor2 
hi def link EpadAuthor3  EpadColorAuthor3 
hi def link EpadAuthor4  EpadColorAuthor4 
hi def link EpadAuthor5  EpadColorAuthor5 
hi def link EpadAuthor6  EpadColorAuthor6 
hi def link EpadAuthor7  EpadColorAuthor7 
hi def link EpadAuthor8  EpadColorAuthor8 
hi def link EpadAuthor9  EpadColorAuthor9
hi def link EpadAuthor10 EpadColorAuthor10
hi def link EpadAuthor11 EpadColorAuthor11
hi def link EpadAuthor12 EpadColorAuthor12
hi def link EpadAuthor13 EpadColorAuthor13
hi def link EpadAuthor14 EpadColorAuthor14
hi def link EpadAuthor15 EpadColorAuthor15
hi def link EpadAuthor16 EpadColorAuthor16
hi def link EpadAuthor17 EpadColorAuthor17
hi def link EpadAuthor18 EpadColorAuthor18
hi def link EpadAuthor19 EpadColorAuthor19
hi def link EpadAuthor20 EpadColorAuthor20
hi def link EpadAuthor21 EpadColorAuthor21
hi def link EpadAuthor22 EpadColorAuthor22
hi def link EpadAuthor23 EpadColorAuthor23
hi def link EpadAuthor24 EpadColorAuthor24
hi def link EpadAuthor25 EpadColorAuthor25
hi def link EpadAuthor26 EpadColorAuthor26
hi def link EpadAuthor27 EpadColorAuthor27
hi def link EpadAuthor28 EpadColorAuthor28
hi def link EpadAuthor29 EpadColorAuthor29
hi def link EpadAuthor30 EpadColorAuthor30
hi def link EpadAuthor31 EpadColorAuthor31
hi def link EpadAuthor32 EpadColorAuthor32
hi def link EpadAuthor33 EpadColorAuthor33
hi def link EpadAuthor34 EpadColorAuthor34
hi def link EpadAuthor35 EpadColorAuthor35
hi def link EpadAuthor36 EpadColorAuthor36
hi def link EpadAuthor37 EpadColorAuthor37
hi def link EpadAuthor38 EpadColorAuthor38
hi def link EpadAuthor39 EpadColorAuthor39
hi def link EpadAuthor40 EpadColorAuthor40
hi def link EpadAuthor41 EpadColorAuthor41
hi def link EpadAuthor42 EpadColorAuthor42
hi def link EpadAuthor43 EpadColorAuthor43
hi def link EpadAuthor44 EpadColorAuthor44
hi def link EpadAuthor45 EpadColorAuthor45
hi def link EpadAuthor46 EpadColorAuthor46
hi def link EpadAuthor47 EpadColorAuthor47
hi def link EpadAuthor48 EpadColorAuthor48
hi def link EpadAuthor49 EpadColorAuthor49
hi def link EpadAuthor50 EpadColorAuthor50
hi def link EpadAuthor51 EpadColorAuthor51
hi def link EpadAuthor52 EpadColorAuthor52
hi def link EpadAuthor53 EpadColorAuthor53
hi def link EpadAuthor54 EpadColorAuthor54
hi def link EpadAuthor55 EpadColorAuthor55
hi def link EpadAuthor56 EpadColorAuthor56
hi def link EpadAuthor57 EpadColorAuthor57
hi def link EpadAuthor58 EpadColorAuthor58
hi def link EpadAuthor59 EpadColorAuthor59
hi def link EpadAuthor60 EpadColorAuthor60
hi def link EpadAuthor61 EpadColorAuthor61
hi def link EpadAuthor62 EpadColorAuthor62
hi def link EpadAuthor63 EpadColorAuthor63

let g:epad_pad = "test"
let g:epad_host = "localhost"
let g:epad_port = "9001"
let g:epad_path = "p/"
let g:epad_verbose = 0 " set to 1 for low verbosity, 2 for debug verbosity

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

pyepad_env = {'epad': None, 'text': None, 'updated': False}

def _update_buffer():
    """
    This function is polled by vim to updated its current buffer
    """
    if pyepad_env['updated']:
        text_obj = pyepad_env['text']
        text_str = pyepad_env['text'].decorated(style=Style.STYLES['Raw']())
        vim.current.buffer[:] = [l.encode('utf-8') for l in text_str.splitlines()]
        c, l = (1, 1)
        for i in range(0, 63):
            vim.command('syn clear EpadAuthor'+str(i))
        for i in range(0, len(text_obj)):
            attr = text_obj.get_author_idx(i)
            vim.command('syn match EpadAuthor'+str(attr)+' /\%'+str(l)+'l\%'+str(c)+'c./')
            c += 1
            if text_obj.get_char(i) == '\n':
                l += 1
                c = 0
        vim.command('redraw!')

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

    try:
        pyepad_env['epad'] = EtherpadIO(padid, vim_link, host, path, port, verbose, 
                                        transports=['websocket'], 
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
        pyepad_env['epad'].disconnect()

EOS

command! -nargs=* Etherpad :python _launch_epad(<f-args>)
command! -nargs=* EtherpadStop :python _stop_epad(<f-args>)
command! -nargs=* EtherpadPause :python _pause_epad(<f-args>)
command! -nargs=* EtherpadUpdate :python _vim_to_epad_update(<f-args>)


