INSTDIR=/home/httpd/html/foster-abc
FORMAT_DIRS=abc pdf jpg midi
OWNER=root
GROUP=root
FILE_FLAGS=-C -o $(OWNER) -g $(GROUP) -m 0444 
DIR_FLAGS=-C -o $(OWNER) -g $(GROUP) -m 0755

DISTVNAME=abc-fakebook-0.01


INSTALL=/usr/bin/install


default ::
	@echo usage: make (install|dist)

help :: default

dist ::
	

install ::
	$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)
	$(INSTALL) $(FILE_FLAGS) index.html dhandler autohandler $(INSTDIR)
	for d in $(FORMAT_DIRS) ; do \
		$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)/$$f ;\
		$(INSTALL) $(FILE_FLAGS) $$f dhandler $(INSTDIR)/$$f ;\
		done
	$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)/abc-src
	$(INSTALL) $(FILE_FLAGS) abc-src/*.abc $(INSTDIR)/abc-src
	$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)/images
	$(INSTALL) $(FILE_FLAGS) images/*.jpg images/*.gif $(INSTDIR)/images


distcheck :
	$(PERL) -MExtUtils::Manifest=fullcheck \
	-e fullcheck

manifest :
	$(PERL) -MExtUtils::Manifest=mkmanifest \
	-e mkmanifest

distdir :
	$(RM_RF) $(DISTVNAME)
	$(PERL)  -MExtUtils::Manifest=manicopy,maniread \
	-e "manicopy(maniread(),'$(DISTVNAME)', 'best');"

dist: $(DIST_DEFAULT)

SUFFIX=.gz

tardist : $(DISTVNAME).tar$(SUFFIX)

$(DISTVNAME).tar$(SUFFIX) : distdir
	$(TAR) --owner=$(INSTALL_OWNER) --group=$(INSTALL_GROUP) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar

