
if exists('g:loaded_vim_etherpad') || &cp
  finish
endif
let g:loaded_vim_etherpad = 1

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

pyepad_env = {'epad': None, 'text': None}

def _launch_epad(*args):
    padid = "test"
    host = "localhost"
    port = "9001"
    path = "p/"
    verbose = False

    logging.basicConfig()
    logging.root.setLevel(logging.DEBUG)

    def vim_link(text):
        # print "vim_link for %s" % str(text)
        if not text is None:
            pyepad_env['text'] = text
            text = text.decorated(style=Style.STYLES['Raw']())
            vim.current.buffer[:] = [l.encode('utf-8') for l in text.splitlines()]
            vim.command('redraw!')

    def on_disconnect():
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
        print err
        vim.command('echoerr "Couldn\'t connect to Etherpad: http://%s:%s/%s%s"' % (host, port, path, padid))

def _pause_epad():
    if not pyepad_env['epad'].has_ended():
        pyepad_env['epad'].pause()
    else:
        vim.command('echoerr "not connected to Etherpad"')

def _vim_to_epad_update():
    if not pyepad_env['epad'].has_ended():
        pyepad_env['epad'].patch_text(pyepad_env['text'], "\n".join(vim.current.buffer[:]))
    else:
        vim.command('echoerr "not connected to Etherpad"')


def _stop_epad(*args):
    if pyepad_env['epad'] and not pyepad_env['epad'].has_ended():
        pyepad_env['epad'].disconnect()

EOS

command! -nargs=* Etherpad :python _launch_epad(<f-args>)
command! -nargs=* EtherpadStop :python _stop_epad(<f-args>)
command! -nargs=* EtherpadPause :python _pause_epad(<f-args>)
command! -nargs=* EtherpadUpdate :python _vim_to_epad_update(<f-args>)


