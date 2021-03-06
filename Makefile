OUT = xqp
VERCMD  ?= git describe 2> /dev/null
VERSION := $(shell $(VERCMD) || cat VERSION)

CPPFLAGS += -D_POSIX_C_SOURCE=200112L -DVERSION=\"$(VERSION)\"
CFLAGS   += -std=c99 -pedantic -Wall -Wextra
LDLIBS   := -lxcb

PREFIX    ?= /usr/local
BINPREFIX ?= $(PREFIX)/bin

SRC := $(wildcard *.c)
OBJ := $(SRC:.c=.o)

all: $(OUT)

debug: CFLAGS += -O0 -g
debug: $(OUT)

$(OBJ): Makefile

install:
	mkdir -p "$(DESTDIR)$(BINPREFIX)"
	cp -p $(OUT) "$(DESTDIR)$(BINPREFIX)"

uninstall:
	rm -f "$(DESTDIR)$(BINPREFIX)"/$(OUT)

clean:
	rm -f $(OUT) $(OBJ)

.PHONY: all debug install uninstall clean
