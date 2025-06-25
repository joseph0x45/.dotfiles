CC = gcc
CFLAGS = -Wall -Werror -std=c17 -pedantic -Wextra

build-volumectl:
	gcc -Wall -pedantic volumectl.c

bin:
	@echo Building Zen
	$(CC) $(CFLAGS) zen.c -o bin/zen
	@echo Building Teams-For-Linux
	$(CC) $(CFLAGS) zen.c -o bin/teams-for-linux
