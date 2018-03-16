IMAGE:=tqxr/node-workbench-image
BINPATH:=/usr/local/bin/

ITEM_WORKBENCH:=node-workbench
ALL_ITEMS:= node npm jshint eslint js-beautify html-beautify css-beautify html-minifier imagemin pug gulp


define RUN_COMMAND
printf '#!/bin/bash \ndocker run -it --rm -v `pwd`:`pwd` -w `pwd` $(IMAGE) $(BINPATH)$(THE_ITEM) "$$@"\n' > $(BINPATH)$(THE_ITEM) ; chmod u+x $(BINPATH)$(THE_ITEM) ;
endef
export RUN_COMMAND

define CLEANUP_COMMAND
rm -f $(BINPATH)$(THE_ITEM)
endef
export CLEANUP_COMMAND

define RUN_COMMAND_WORKBENCH
#!/bin/bash
docker run -it --rm        \
--name tqxr-node-workbench \
-v `pwd`:`pwd` -w `pwd`    \
-h $(IMAGE).local          \
$(IMAGE) "$$@"
endef
export RUN_COMMAND_WORKBENCH


create-command:
	echo "$$RUN_COMMAND_WORKBENCH" > "/usr/local/bin/${ITEM_WORKBENCH}"
	chmod u+x "/usr/local/bin/${ITEM_WORKBENCH}"
	@$(foreach THE_ITEM, $(ALL_ITEMS), $(RUN_COMMAND) )

build:
	docker build -t $(IMAGE) .

install: create-command build
	@:


cleanup-commands:
	@$(foreach THE_ITEM, $(ALL_ITEMS), $(CLEANUP_COMMAND))
	rm -f /usr/local/bin/$(ITEM_WORKBENCH)

uninstall: cleanup-commands
	docker rmi $(IMAGE)


shell:
	docker run -it --rm -v `pwd`/app:/app $(IMAGE)
