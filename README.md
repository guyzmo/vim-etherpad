# Etherpad Client for VIM

This plugin uses [EtherpadLiteClient](https://github.com/guyzmo/PyEtherpadLite) to connect
to a pad on an [EtherPadLite server](https://github.com/ether/etherpad-lite) and enables collaborative edition in your favorite editor.

<video width="500" controls>
<source src="http://m0g.net/vim-etherpad-screencast.mp4" type="video/mp4">
<source src="http://m0g.net/vim-etherpad-screencast.ogv" type="video/ogg">
[![Demo](http://m0g.net/vim-etherpad-screencast.gif)<br />
Click me for a demo video of good quality](http://m0g.net/vim-etherpad/)
</video>

# Disclaimer

As is, the plugin is only a Proof-of-Concept, that is still not configurable and not fail-proof.
It can only get updates from the server, but still not send updates to the server.
The Vim integration is still pretty… alpha.

Supports pad connection using `websocket` flawlessly, but `xhr-polling` is still beta (it may need several reconnections to work).

# Develop

Vim needs to be compiled with the `python` option enabled.

There's a dependency on the python library `requests`:

    pip install requests

To run the plugin for dev or testing, you can launch vim as follows:

    vim -c 'source plugin/vim-etherpad.vim'

# Configuration in .vimrc

    " To connect to the pad at URI http://localhost:9001/p/test per default:
    let g:epad_host = "localhost" " Hostname to connect to
    let g:epad_port = "9001"      " Port to connect to
    let g:epad_path = "p/"        " URL Path to the pad
    let g:epad_pad = "foo"        " Name of the pad to connect to
    
    " Enable verbosity
    let g:epad_verbose = 0        " set to 1 for INFO level, 2 for DEBUG level
    leg g:epad_updatetime = 1000  " lower this for more realtime, higher this for less load

# Use

## To connect to a pad:

    :Etherpad     " connects to the default URI spec and default pad
    :Etherpad foo " connects to the 'foo' pad at default URI
    :Etherpad http://beta.etherpad.org/p/test " connects to that pad's URI
    :Etherpad https://pad.lqdn.fr/p/test      " another one

## To disconnect from a pad:

    :EtherpadStop
    
## To pause current pad connection:

    :EtherpadPause
    
## To try sending an update (will fail, changeset building library is work in progress):

    :EtherpadUpdate

# Install

though install is still not recommended, you can install it as a Vundle bundle:

    Bundle 'guyzmo/vim-etherpad'

# License

All the plugin's code is under the GPLv3.

