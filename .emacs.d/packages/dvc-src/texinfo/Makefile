

##############################################################################
# location of required programms
RM   = /bin/rm
XARGS = xargs
ETAGS = etags
BZR = bzr
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
MAKEINFO = makeinfo
TEXI2DVI = texi2dvi

EMACS_PROG = emacs -no-site-file -no-init-file
EMACS_FLAVOR = emacs
EMACS_VERSION = 23.0.60.2

# Other settings
SYMLINKS = no
LINKPATH = 

datarootdir = ${prefix}/share
prefix = /home/blender/.emacs.d/packages/dvc-src/../dvc
info_dir = ${datarootdir}/info

##############################################################################
all: info dvc.dvi  dvc.html dvc.pdf

dvi: dvc.dvi

pdf: dvc.pdf

html: dvc.html

Makefile: ./Makefile.in ../config.status
	cd ..; ./config.status

install: uninstall info
	$(INSTALL) -d -m 0755 $(info_dir);                             \
	if test "x$(SYMLINKS)" = "xno" ; then                          \
          for i in `ls dvc.info* ` ; do                                \
	    echo "Installing $$i in $(info_dir)" ;                     \
            $(INSTALL_DATA) $$i $(info_dir) ;                          \
          done ;                                                       \
        else                                                           \
          if test "x$(LINKPATH)" = "x" ; then                          \
            for i in `ls dvc.info* ` ; do                              \
              echo "Linking $$i in $(info_dir)" ;                      \
              $(LN_S) `pwd`/$$i $(info_dir)/$$i ;                      \
            done ;                                                     \
          else                                                         \
            for i in `ls dvc.info* ` ; do                              \
              echo "Linking $(LINKPATH)/texinfo/$$i in $(info_dir)" ;  \
              $(LN_S) $(LINKPATH)/texinfo/$$i $(info_dir)/$$i ;        \
            done ;                                                     \
          fi ;                                                         \
        fi
	@echo DVC INFO files successfully installed\!

uninstall:
	-$(RM) -f $(info_dir)/dvc.info*

info: dvc.info

dvc.info: ./dvc.texinfo ./dvc-version.texinfo
	@if test "x$(MAKEINFO)" = "x" ; then                  \
           $(EMACSINFO) ./dvc.texinfo -o $@ ;          \
         else                                                 \
           $(MAKEINFO) ./dvc.texinfo -o $@ ;           \
         fi

dvc.html: ./dvc.texinfo ./dvc-version.texinfo
	@if test "x$(MAKEINFO)" = "x" ; then                    \
           $(EMACSINFO) ./dvc.texinfo ;                  \
         else                                                   \
           $(MAKEINFO) --html --no-split ./dvc.texinfo ; \
         fi

dvc.dvi: ./dvc.texinfo ./dvc-version.texinfo
	@if test "x$(TEXI2DVI)" = "x" ; then                 \
           echo "Sorry, no \`texi2dvi' program available." ; \
         else                                                \
           $(TEXI2DVI) ./dvc.texinfo -o $@ ;          \
         fi

dvc.pdf: ./dvc.texinfo ./dvc-version.texinfo
	@if test "x$(TEXI2DVI)" = "x" ; then                 \
           echo "Sorry, no \`texi2dvi' program available." ; \
         else                                                \
           $(TEXI2DVI) -p ./dvc.texinfo -o $@;        \
         fi

clean:
	-$(RM) -f *.aux *.cp *.cps *.dvi *.pdf *.fn *.fns *.ky *.log *.pg \
	  *.toc *.tp *.vr *.vrs *.html *.info dvc-version.texinfo

distclean: clean
	-$(RM) -f Makefile

.PHONY: pdf dvi html info clean distclean install-pkg uninstall-pkg all

BZR_DIR_EXISTS=${shell if [ -r '../.bzr' ]; then printf "%s" yes; else printf "%s" no; fi }
BZR_REVISION_CMD=cd .. && $(BZR) version-info | sed -ne 's/^revision-id: //p'

ifeq ($(BZR_DIR_EXISTS),yes)
dvc-version.texinfo: ../.bzr
	$(RM) -f $@
	printf "%s" "@verbatim " >> $@
	if [ "x$(RELEASE_ID)" != "x" ]; then                         \
		printf "%s (%s)" $(RELEASE_ID)                       \
		`$(BZR_REVISION_CMD)` >> $@;                         \
	else                                                         \
		($(BZR_REVISION_CMD)) >> $@;                         \
	fi
	@echo >> $@
	@echo "@end verbatim" >> $@
	chmod -w $@
else
dvc-version.texinfo:
	$(RM) -f $@
	@echo "*** Warning: Unknown DVC arch release"
	if [ "x$(RELEASE_ID)" != "x" ]; then         \
		printf "%s" "$(RELEASE_ID)" >> $@;   \
	else                                         \
		printf "%s" "Unknown version" >> $@; \
	fi
	chmod -w $@
endif
