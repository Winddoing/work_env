CC     = $(CROSS_COMPILE)gcc
CFLAGS = -Wall -O -g
LIBS   = -L../pciutils-3.13.0/lib -static -lpci
INCS   = -I../pciutils-3.13.0

SRCS   := $(wildcard *.c)
COBJS  := $(SRCS:.c=.o)

$(info "SRCS: $(SRCS), COBJS:$(COBJS)")

BIN=pciheader
# https://github.com/cjonesii/pciutils/blob/main/pciheader.c

all:$(BIN)

$(COBJS) : %.o: %.c
	$(CC) -c $< -o $@ $(INCS) $(CFLAGS)

$(BIN):$(COBJS)
	$(CC) -o $(BIN) $(COBJS) $(LIBS) $(CFLAGS)

clean:
	rm $(BIN) $(COBJS)
