dist_bin_SCRIPTS =
dist_bin_SCRIPTS += kernel-builder

sysconf_DATA =
sysconf_DATA += kernel-builder.conf

pkgdata_DATA =
pkgdata_DATA += kernel-builder.sh

dist_pkgdata_SCRIPTS =
dist_pkgdata_SCRIPTS += kernel-tar


install-exec-hook:
	sed -i 's|__LIBDIR__|$(pkgdatadir)|' $(DESTDIR)$(bindir)/kernel-builder
	sed -i 's|__CONFDIR__|$(sysconfdir)|' $(DESTDIR)$(bindir)/kernel-builder
