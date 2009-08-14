##############################################################################
# (c) SZABO Gergely, 2009
# Free software, distributed under the GNU GPL license
# There is absolutely no warranty.
##############################################################################


####### Macros #######

# Target and sources
TARGET := go
MANPAGE:= go.1.gz
BIN    := /usr/bin
MAN    := /usr/share/man/man1


####### Rules ########

# Run "sudo make" to install
# Install to $(BIN) and man page to $(MAN)
install:
	cp -f $(TARGET) $(BIN)
	cp -f $(MANPAGE) $(MAN)

# Run "sudo make uninstall" to uninstall
# Uninstall from $(BIN) and man page from $(MAN)
uninstall:
	rm -f $(BIN)/$(TARGET)
	rm -f $(MAN)/$(MANPAGE)

# Remove backup files
clean:
	rm -f *~

