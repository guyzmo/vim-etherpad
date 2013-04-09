# Etherpad Client for VIM

This plugin uses [EtherpadLiteClient](https://github.com/guyzmo/EtherpadLiteClient) to connect
to a pad on an EtherPadLite server and enables collaborative edition in your favorite editor.

# Disclaimer

As is, the plugin is only a Proof-of-Concept, that is still not configurable and not fail-proof.
It can only get updates from the server, but still not send updates to the server.
The Vim integration is still pretty… alpha.

# Develop

Vim needs to be compiled with the `python` option enabled.

There's a dependency on the python library `requests`:

    pip install requests

To run the plugin for dev or testing, you can launch vim as follows:

    vim -c 'source plugin/vim-etherpad.vim' -c 'Etherpad'

# Install

though install is still not recommended, you can install it as a Vundle bundle:

    Bundle 'guyzmo/vim-etherpad'

# License

All the plugin's code is under the GPLv3.

