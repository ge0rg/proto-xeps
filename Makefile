FROM_XMPP_GIT := xmpp.css prettify.js prettify.css
XEPS := $(shell find -mindepth 1 -maxdepth 1 -type d -name 'xep-*')

.PHONY: all clean distclean init sync $(XEPS)

all: $(XEPS)

init: $(FROM_XMPP_GIT)

clean:
	rm -rf $(FROM_XMPP_GIT)

distclean:
	rm -rf $(FROM_XMPP_GIT)
	TARGET=clean $(MAKE) $(XEPS)

xmpp.css: xsf-xeps/xmpp.css
	cp $^ $@

prettify.css: xsf-xeps/prettify.css
	cp $^ $@

prettify.js: xsf-xeps/prettify.js
	cp $^ $@

$(XEPS): init
	$(MAKE) -C $@ $(TARGET)

deploy: all
	./deploy.sh
