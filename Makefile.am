ACLOCAL_AMFLAGS = -I m4

themedir  = $(datadir)/themes
adaptadir = $(DESTDIR)$(themedir)/Adapta

SUBDIRS = \
	gtk \
	shell \
	wm \
	extra

EXTRA_DIST = \
	COPYING \
	LICENSE_CC_BY_SA4 \
	README.md

install-data-hook:
	cp -Rv $(EXTRA_DIST) $(adaptadir)

uninstall-hook:
	test -e $(adaptadir) && rm -rfv $(adaptadir)
