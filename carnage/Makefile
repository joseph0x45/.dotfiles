CC = gcc
CFLAGS = -Wall
SRC = $(wildcard *c)
BIN = $(SRC:.c=)

all: $(BIN)

%: %.c
	$(CC) $(CFLAGS) $< -o ./bin/$@

clear:
	rm -f $(BIN)
