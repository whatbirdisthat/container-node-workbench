# A container for NodeJS and some tools

This toolbox contains a collection of tools which require nodejs to run.

1. jshint
2. eslint
3. js-beautify
    * html-beautify
    * css-beautify

These commands are exposed in `/usr/local/bin` but they end up being
pretty slow, because they create a new container every time.

To speed things up, another command is added: `/usr/local/bin/node-workbench` which
fires up a new container, mounting `$PWD` and all the commands are available inside it.


I don't know how useful this is, but time will tell.

If I use it heaps and it makes life easier, I will update this README with all
the cheering.

