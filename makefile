##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the GNU GPL license
# There is absolutely no warranty.
##############################################################################


####### Macros #######

# Target and sources
TARGET1 := go
TARGET2 := google
MANPAGE1:= go.1.gz
MANPAGE2:= google.1.gz
BIN     := /usr/bin
MAN     := /usr/share/man/man1
TARBALL := go.tar.gz

####### Rules ########

# Run "sudo make" to install
# Install to $(BIN) and man page to $(MAN)
install:
	cp -f $(TARGET1) $(BIN)
	cp -f $(TARGET2) $(BIN)
	cp -f $(MANPAGE1) $(MAN)
	cp -f $(MANPAGE2) $(MAN)

# Run "sudo make uninstall" to uninstall
# Uninstall from $(BIN) and man page from $(MAN)
uninstall:
	rm -f $(BIN)/$(TARGET1)
	rm -f $(BIN)/$(TARGET2)
	rm -f $(MAN)/$(MANPAGE1)
	rm -f $(MAN)/$(MANPAGE2)

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

$(TARBALL): *
	7z a $(TARBALL:.tar.gz=.tar) *
	7z a $(TARBALL) $(TARBALL:.tar.gz=.tar)
	rm -f $(TARBALL:.tar.gz=.tar)
