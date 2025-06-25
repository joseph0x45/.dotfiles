#include <curl/curl.h>
#include <getopt.h>
#include <stdlib.h>
#include <string.h>

#define ZEN_PATH "/home/joseph/.local/zen"
#define UPDATE_URL "https://app-versions-three.vercel.app/api/versions?name=zen"

// install to /home/joseph/.local/Zen
// update: check version first
// without parameters, directly run Zen

int main(int argc, char **argv) {
  if (argc == 1) {
    system(ZEN_PATH);
  }
  if (argc == 2) {
    if (strcmp(argv[1], "install")) {
    } else if (strcmp(argv[1], "update")) {
    }
  }
}
