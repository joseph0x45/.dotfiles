#include "common.h"
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UPDATE_URL "https://app-versions-three.vercel.app/api/versions?name=zen"
#define ZEN_PATH "/home/joseph/.local/zen"
#define GET_VERSION_CMD                                                        \
  "/home/joseph/.local/zen --version | awk '{print $NF}' | tr -d '\\n'"
#define GET_API_DATA_URL "curl " UPDATE_URL
#define SET_ZEN_EXECUTABLE "chmod u+x " ZEN_PATH

int main(int argc, char **argv) {
  int opt;
  char command[1024];
  int result = 0;
  char version[100];
  char api_data[5000];
  while ((opt = getopt(argc, argv, "vp:iu")) != -1) {
    switch (opt) {
    case 'v':
      result = run_command(GET_VERSION_CMD, version, sizeof(version));
      if (result == -1) {
        perror("Error");
        return 1;
      }
      printf("Mozilla Zen %s\n", version);
      return 0;
    case 'p':
      if (optarg == NULL) {
        return 1;
      }
      snprintf(command, sizeof(command), "%s -P %s", ZEN_PATH, optarg);
      if (system(command) == -1) {
        perror("Error running zen with profile");
        return 1;
      }
      return 0;
    case 'i':
      printf("Fetching latest version from API\n");
      fflush(stdout);
      result = run_command(GET_API_DATA_URL, api_data, sizeof(api_data));
      if (result == -1) {
        perror("Error while fetching latest Zen version");
        return 1;
      }
      char *token = strtok(api_data, " ");
      printf("Got latest version %s\n", token);
      token = strtok(NULL, " ");
      printf("Downloading from %s\n", token);
      result = download(token, ZEN_PATH);
      if (result == -1) {
        perror("Error while downloading latest Zen version");
        return 1;
      }
      // make binary executable
      result = system(SET_ZEN_EXECUTABLE);
      if (result == -1) {
        perror("Error while setting Zen to be executable");
        return 1;
      }
      printf("Zen installed successfully");
      return 0;
    case 'u':
      // check for version against latest one
      // download if no match
    default:
      printf("Unrecognized option");
      return 1;
    }
  }
}
