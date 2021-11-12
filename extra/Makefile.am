themedir     = $(datadir)/themes
adaptadir    = $(DESTDIR)$(themedir)/Adapta

geditdir   = $(srcdir)/gedit
gedit_file = \
	$(geditdir)/adapta.xml \
	$(geditdir)/README.md

# *****************
# * Install files *
# *****************

install-data-local:
	$(MKDIR_P) $(adaptadir)/gedit
	cp -Rv $(gedit_file) $(adaptadir)/gedit
	cd $(adaptadir)

# *******************
# * Uninstall files *
# *******************

uninstall-local:
	test -e $(adaptadir)/gedit && rm -rfv $(adaptadir)/gedit

# ****************************
# * Clean up generated files *
# ****************************

CLEANFILES =

DISTCLEANFILES = \
	$(CLEANFILES)
