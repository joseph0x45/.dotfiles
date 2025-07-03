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

int get_zen_current_version(char *version) {
  int result = run_command(GET_VERSION_CMD, version, sizeof(version));
  if (result == -1) {
    perror("Error while getting Zen current version:");
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

int main(int argc, char **argv) {
  int opt;
  char command[1024];
  int result = 0;
  char version_str[100];
  while ((opt = getopt(argc, argv, "vP:p:iu")) != -1) {
    switch (opt) {
    case 'v':
      result = get_zen_current_version(version_str);
      if (result == -1) {
        perror("Error");
        return 1;
      }
      printf("Mozilla Zen %s\n", version_str);
      return 0;
    case 'P':
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
      printf("Fetching latest Zen version from API\n");
      fflush(stdout);
      LatestVersion *version = get_latest_version_data(GET_API_DATA_URL);
      if (!version) {
        return EXIT_FAILURE;
      }
      result = install(version, ZEN_PATH, SET_ZEN_EXECUTABLE, "Zen");
      free(version);
      return result;
    case 'u': {
      printf("Fetching latest version from API\n");
      fflush(stdout);
      LatestVersion *version = get_latest_version_data(GET_API_DATA_URL);
      if (!version) {
        return EXIT_FAILURE;
      }
      result = get_zen_current_version(version_str);
      if (result == EXIT_FAILURE) {
        return EXIT_FAILURE;
      }
      if (strcmp(version_str, version->tag_name) == 0) {
        printf("You have the latest Zen version yay \\o/\n");
        return 0;
      }
      result = install(version, ZEN_PATH, SET_ZEN_EXECUTABLE, "Zen");
      if (result == EXIT_FAILURE) {
        free(version);
        return EXIT_FAILURE;
      }
      printf("Zen has been updated to %s successfully!", version->tag_name);
      free(version);
      return EXIT_SUCCESS;
    }
    default:
      printf("Unrecognized option");
      return 1;
    }
  }
  result = system(ZEN_PATH);
  if (result == -1) {
    perror("Error while running Zen:");
    return 1;
  }
  return 0;
}
