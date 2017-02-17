NULL = 

AM_CPPFLAGS = \
	$(addusergtk_CFLAGS) \
	-include config.h \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPKGDATADIR=\""$(pkgdatadir)"\" \
	$(NULL)

bin_PROGRAMS = addusergtk

addusergtk_SOURCES = input_user.vala \
	$(NULL)

addusergtk_VALAFLAGS = \
    --vapidir ../vapi \
		--pkg config \
    $(VALA_PACKAGES) \
    $(NULL)

addusergtk_LDADD = \
	$(addusergtk_LIBS) \
	$(NULL)

EXTRA_DIST = \
	$(NULL)

DISTCLEANFILES = \
	$(NULL)
