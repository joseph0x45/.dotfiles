CC = gcc
CFLAGS = -Wall -Werror -std=c17 -pedantic -Wextra

.PHONY: all clean

zen: zen.c | bin
	@echo Building Zen
	$(CC) $(CFLAGS) zen.c -o bin/zen

teams: teams.c | bin
	@echo Building Teams For Linux
	$(CC) $(CFLAGS) teams.c -o bin/teams

bin:
	@mkdir -p bin


.PHONY: bin
