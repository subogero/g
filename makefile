##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the WTFPL license
##############################################################################


####### Macros #######

# Target and sources
TARGET1 := g
TARGET2 := tapeta
TARGET3 := notgmail
MANPAGE1:= g.1
MANPAGE2:= tapeta.1
MANPAGE3:= notgmail.1
BIN     := /usr/bin
MAN     := /usr/share/man/man1
TARBALL := g.tar.gz

####### Rules ########

# Run "sudo make" to install
# Install to $(BIN) and man page to $(MAN)
install:
	cp -f $(TARGET1) $(BIN)
	cp -f $(TARGET2) $(BIN)
	cp -f $(TARGET3) $(BIN)
	cp -f $(MANPAGE1) $(MAN)
	gzip --best $(MAN)/$(MANPAGE1)
	cp -f $(MANPAGE2) $(MAN)
	gzip --best $(MAN)/$(MANPAGE2)
	cp -f $(MANPAGE3) $(MAN)
	gzip --best $(MAN)/$(MANPAGE3)

# Run "sudo make uninstall" to uninstall
# Uninstall from $(BIN) and man page from $(MAN)
uninstall:
	rm -f $(BIN)/$(TARGET1)
	rm -f $(BIN)/$(TARGET2)
	rm -f $(BIN)/$(TARGET3)
	rm -f $(MAN)/$(MANPAGE1).gz
	rm -f $(MAN)/$(MANPAGE2).gz
	rm -f $(MAN)/$(MANPAGE3).gz

# Remove backup files
clean:
	rm -f *~
	rm -f $(TARBALL)

# Create compressed tarball
release: commit $(TARBALL)

# Commit to git repository
commit: clean
	@git tag;\
	echo Please Enter git tag name:;\
	export TAG;\
	read TAG;\
	echo Adding git tag $$TAG;\
	git commit -a;\
	git tag -a `echo $$TAG` HEAD

$(TARBALL):
	7z a $(TARBALL:.tar.gz=.tar) *
	7z a $(TARBALL) $(TARBALL:.tar.gz=.tar)
	rm -f $(TARBALL:.tar.gz=.tar)
