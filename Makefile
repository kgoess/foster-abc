INSTDIR=/home/httpd/html/mason/foster-abc
FORMAT_DIRS=abc pdf jpg midi

INSTALL_OWNER=root
INSTALL_GROUP=root
FILE_FLAGS=-C -o $(INSTALL_OWNER) -g $(INSTALL_GROUP) -m 0444 
DIR_FLAGS=-C -o $(INSTALL_OWNER) -g $(INSTALL_GROUP) -m 0755

SRC_OWNER=kevin
SRC_GROUP=kevin
SRC_DIR_FLAGS=-C -o $(SRC_OWNER) -g $(SRC_GROUP) -m 0755

WEBSERVER_OWNER=nobody
WEBSERVER_GROUP=nobody
MASON_DATA_DIR=/home/httpd/html/mason/mason-data
MASON_DATA_DIR_FLAGS=-C -o $(WEBSERVER_OWNER) -g $(WEBSERVER_GROUP) -m 0755 -d $(MASON_DATA_DIR)

# end of user settings

DISTVNAME=abc-fakebook-0.07


INSTALL=/usr/bin/install
PERL=/usr/local/bin/perl
RM_RF = /bin/rm -rf
SUFFIX = .gz
TAR = /bin/tar
TARFLAGS = -cvf
COMPRESS = gzip



default ::
	@echo 'usage: make (install|dist)'

help :: default


install ::
	$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)
	$(INSTALL) $(FILE_FLAGS) index.html autohandler config beforetext aftertext $(INSTDIR)
	for d in $(FORMAT_DIRS) ; do \
		$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)/$$d ;\
		$(INSTALL) $(FILE_FLAGS) $$d/dhandler $(INSTDIR)/$$d/ ;\
		done
	$(INSTALL) $(SRC_DIR_FLAGS) -d $(INSTDIR)/abc-src
	$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)/images
	$(INSTALL) $(FILE_FLAGS) images/*.jpg images/*.gif $(INSTDIR)/images
	$(INSTALL) $(DIR_FLAGS) -d $(INSTDIR)/images
	$(INSTALL) $(MASON_DATA_DIR_FLAGS) -d $(MASON_DATA_DIR)


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

dist : $(DISTVNAME).tar.gz

$(DISTVNAME).tar.gz : distdir
	$(TAR) --owner=$(INSTALL_OWNER) --group=$(INSTALL_GROUP) $(TARFLAGS) $(DISTVNAME).tar $(DISTVNAME)
	$(RM_RF) $(DISTVNAME)
	$(COMPRESS) $(DISTVNAME).tar

