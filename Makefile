IMAGE:=node-workbench-image

ITEM_NODE:=node
ITEM_NPM:=npm
ITEM_JSHINT:=jshint
ITEM_ESLINT:=eslint
ITEM_JS_BEAUTIFY:=js-beautify
ITEM_HTML_BEAUTIFY:=html-beautify
ITEM_CSS_BEAUTIFY:=css-beautify

ITEM_WORKBENCH:=node-workbench

BINPATH=/usr/local/bin/

define RUN_COMMAND_WORKBENCH
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
-h $(IMAGE).local                                            \
$(IMAGE) "$$@"
endef
export RUN_COMMAND_WORKBENCH

define RUN_COMMAND_NODE
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)$(ITEM_NODE) "$$@"
endef
export RUN_COMMAND_NODE

define RUN_COMMAND_NPM
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)$(ITEM_NPM) "$$@"
endef
export RUN_COMMAND_NPM

define RUN_COMMAND_JSHINT
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)$(ITEM_JSHINT) "$$@"
endef
export RUN_COMMAND_JSHINT
define RUN_COMMAND_ESLINT
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)$(ITEM_ESLINT) "$$@"
endef
export RUN_COMMAND_ESLINT
define RUN_COMMAND_JS_BEAUTIFY
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)js-$(ITEM_JS_BEAUTIFY) "$$@"
endef
export RUN_COMMAND_JS_BEAUTIFY
define RUN_COMMAND_HTML_BEAUTIFY
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)$(ITEM_HTML_BEAUTIFY) "$$@"
endef
export RUN_COMMAND_HTML_BEAUTIFY
define RUN_COMMAND_CSS_BEAUTIFY
#!/bin/bash
docker run -it --rm                                          \
-v `pwd`:`pwd` -w `pwd`                                      \
$(IMAGE) $(BINPATH)$(ITEM_CSS_BEAUTIFY) "$$@"
endef
export RUN_COMMAND_CSS_BEAUTIFY

create-command:
	echo "$$RUN_COMMAND_WORKBENCH" > "/usr/local/bin/${ITEM_WORKBENCH}"
	chmod u+x "/usr/local/bin/${ITEM_WORKBENCH}"
	echo "$$RUN_COMMAND_NPM" > "/usr/local/bin/${ITEM_NPM}"
	chmod u+x "/usr/local/bin/${ITEM_NPM}"
	echo "$$RUN_COMMAND_NODE" > "/usr/local/bin/${ITEM_NODE}"
	chmod u+x "/usr/local/bin/${ITEM_NODE}"
	echo "$$RUN_COMMAND_JSHINT" > "/usr/local/bin/${ITEM_JSHINT}"
	chmod u+x "/usr/local/bin/${ITEM_JSHINT}"
	echo "$$RUN_COMMAND_ESLINT" > "/usr/local/bin/${ITEM_ESLINT}"
	chmod u+x "/usr/local/bin/${ITEM_ESLINT}"
	echo "$$RUN_COMMAND_JS_BEAUTIFY" > "/usr/local/bin/${ITEM_JS_BEAUTIFY}"
	chmod u+x "/usr/local/bin/${ITEM_JS_BEAUTIFY}"
	echo "$$RUN_COMMAND_HTML_BEAUTIFY" > "/usr/local/bin/${ITEM_HTML_BEAUTIFY}"
	chmod u+x "/usr/local/bin/${ITEM_HTML_BEAUTIFY}"
	echo "$$RUN_COMMAND_CSS_BEAUTIFY" > "/usr/local/bin/${ITEM_CSS_BEAUTIFY}"
	chmod u+x "/usr/local/bin/${ITEM_HTML_BEAUTIFY}"

install: create-command build
	@:

build:
	docker build -t $(IMAGE) .

run:
	docker run -it -v `pwd`/app:/app --rm $(IMAGE) node index.js

uninstall:
	rm -f /usr/local/bin/$(ITEM_WORKBENCH)
	rm -f /usr/local/bin/$(ITEM_NODE)
	rm -f /usr/local/bin/$(ITEM_NPM)
	rm -f /usr/local/bin/$(ITEM_JSHINT)
	rm -f /usr/local/bin/$(ITEM_ESLINT)
	rm -f /usr/local/bin/$(ITEM_JS_BEAUTIFY)
	rm -f /usr/local/bin/$(ITEM_HTML_BEAUTIFY)
	rm -f /usr/local/bin/$(ITEM_CSS_BEAUTIFY)
	docker rmi $(IMAGE)

shell:
	docker run -it --rm -v `pwd`/app:/app $(IMAGE) ash
