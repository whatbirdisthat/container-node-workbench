# A container for NodeJS and some tools

This toolbox contains a collection of tools which require nodejs to run.

1. jshint
2. eslint
3. js-beautify
    * html-beautify
    * css-beautify
4. html-minifier
5. imagemin
6. pug
7. gulp

These commands are exposed in `/usr/local/bin` but they end up being
pretty slow, because they create a new container every time.

To speed things up, another command is added: `/usr/local/bin/node-workbench` which
fires up a new container, mounting `$PWD` and all the commands are available inside it.

> I don't know how useful this is, but time will tell.

If I use it heaps and it makes life easier, I will update this README with all
the cheering.

## How to make it work

When you `make install` this it will build a docker image (based on node:alpine) and
npm install the tools and apk add some things needed to build the various native bits that imagemin uses.

Then, some little scripts are added to `/usr/local/bin` that fire up the image as a container
temporarily and run the requested tool passing the params to it.

For example, running `/usr/local/bin/node --version` will call the script that looks like this:

```bash
#!/bin/bash
docker run -it --rm -v `pwd`:`pwd` -w `pwd` tqxr/node-workbench-image /usr/local/bin/node "$@"
```

Which produces the output:

```txt
v9.5.0
```

> If `/usr/local/bin` is in your path, you can use `node --version` and all the things. :)
