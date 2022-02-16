SUBDIRS =
SUBDIRS += src

top_docs = README.md COPYING AUTHORS TODO
deb_examples = debian/control debian/get_deps

EXTRA_DIST =
EXTRA_DIST += $(top_docs)
EXTRA_DIST += $(deb_examples)

man1_MANS = kernel-builder.1

install-data-local:
	$(MKDIR_P) $(DESTDIR)$(docdir)/debian
	cp -r $(top_docs:%=$(srcdir)/%) $(DESTDIR)$(docdir)
	cp -r $(deb_examples:%=$(srcdir)/%) $(DESTDIR)$(docdir)/debian

uninstall-local:
	rm -f $(top_docs:%=$(DESTDIR)$(docdir)/%)
	rm -f $(deb_examples:%=$(DESTDIR)$(docdir)/%)

kernel-builder.1: config.log ./src/kernel-builder kernel-builder.1.include
	help2man -o $@ --no-info --include kernel-builder.1.include ./src/kernel-builder


# i know this isn't the right way to do this... but it's how i've been
# occasionally making .pkg files to install, now documented/automated
# to make life easier.
DEBREV=1
DEBVERSION=$(PACKAGE_VERSION)-$(DEBREV)
DEBNAME=$(PACKAGE_TARNAME)_$(DEBVERSION)
DEBFILE=$(abs_top_builddir)/$(DEBNAME).deb
DPKGDIR=$(abs_top_builddir)/$(DEBNAME)
DEBDIR=$(DPKGDIR)/DEBIAN
DEBCTRL=$(DEBDIR)/control
DEBSIZE=$(DEBDIR)/.size
DEBARCH=$(DEBDIR)/.arch
DEBDEPS=$(DEBDIR)/.deps
DEBCTRL_DEPS=$(DEBSIZE) $(DEBARCH) $(DEBDEPS)

.PHONY: dpkg
dpkg: $(DEBFILE)

$(DEBFILE): $(DEBCTRL)
	rm -f $(DEBCTRL_DEPS)
	dpkg-deb --build --root-owner-group $(DPKGDIR)
	rm -rf $(DPKGDIR)

$(DPKGDIR):
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) DESTDIR=$@ install

$(DEBDIR): $(DPKGDIR)
	$(MKDIR_P) $@

$(DEBSIZE): $(DEBDIR)
	du -s $(DPKGDIR) | awk '{print $$1}' > $@

$(DEBARCH): $(DEBDIR)
	dpkg-architecture --query DEB_HOST_ARCH > $@

$(DEBDEPS): $(DEBDIR)
	$(srcdir)/debian/get_deps $(DPKGDIR) > $(DEBDIR)/.tmp
	awk -F": " '/^pkgs:/ {print $$2}' $(DEBDIR)/.tmp > $@
	rm -f $(DEBDIR)/.tmp

$(DEBCTRL): $(DEBCTRL_DEPS)
	cat $(srcdir)/debian/control | sed \
	    -e 's|__version__|$(DEBVERSION)|' \
	    -e "s|__size__|$$(cat $(DEBDIR)/.size)|" \
	    -e "s|__arch__|$$(cat $(DEBDIR)/.arch)|" \
	    -e "s|__deplibs__|$$(cat $(DEBDIR)/.deps)|" \
	    > $@
