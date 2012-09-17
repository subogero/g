##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the GNU GPL license
# There is absolutely no warranty.
##############################################################################


####### Macros #######

# Target and sources
TARGET1 := go
TARGET3 := tapeta
MANPAGE1:= go.1.gz
BIN     := /usr/bin
MAN     := /usr/share/man/man1
TARBALL := go.tar.gz

####### Rules ########

# Run "sudo make" to install
# Install to $(BIN) and man page to $(MAN)
install:
	cp -f $(TARGET1) $(BIN)
	cp -f $(TARGET3) $(BIN)
	cp -f $(MANPAGE1) $(MAN)

# Run "sudo make uninstall" to uninstall
# Uninstall from $(BIN) and man page from $(MAN)
uninstall:
	rm -f $(BIN)/$(TARGET1)
	rm -f $(BIN)/$(TARGET3)
	rm -f $(MAN)/$(MANPAGE1)

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
