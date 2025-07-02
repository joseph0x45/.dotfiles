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
    return -1;
  }
  return 0;
}

int install_zen(LatestVersion *version) {
  printf("Downloading Zen %s\n", version->tag_name);
  fflush(stdout);
  int result = download(version->download_url, ZEN_PATH);
  if (result == -1) {
    perror("Error while downloading latest Zen version");
    return 1;
  }
  printf("Done!\n");
  printf("Installing Zen %s to %s\n", version->tag_name, ZEN_PATH);
  result = system(SET_ZEN_EXECUTABLE);
  if (result == -1) {
    perror("Error while setting Zen to be executable");
    return 1;
  }
  return 0;
}

int main(int argc, char **argv) {
  int opt;
  char command[1024];
  int result = 0;
  char version[100];
  char api_data[5000];
  while ((opt = getopt(argc, argv, "vP:p:iu")) != -1) {
    switch (opt) {
    case 'v':
      result = get_zen_current_version(version);
      if (result == -1) {
        perror("Error");
        return 1;
      }
      printf("Mozilla Zen %s\n", version);
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
    case 'i': {
      printf("Fetching latest version from API\n");
      fflush(stdout);
      result = run_command(GET_API_DATA_URL, api_data, sizeof(api_data));
      if (result == -1) {
        perror("Error while fetching latest Zen version");
        return 1;
      }
      LatestVersion *version = get_latest_version_data(GET_API_DATA_URL);
      result = install_zen(version);
      printf("Zen %s installed successfully\n", version->tag_name);
      return 0;
    }
    case 'u':
      printf("Fetching latest version from API\n");
      fflush(stdout);
      LatestVersion *latest_version = get_latest_version_data(GET_API_DATA_URL);
      result = run_command(GET_API_DATA_URL, api_data, sizeof(api_data));
      if (result == -1) {
        perror("Error while fetching latest Zen version");
        return 1;
      }
      char *token = strtok(api_data, " ");
      printf("Latest Zen version %s\n", token);
      result = get_zen_current_version(version);
      if (result == -1) {
        return 1;
      }
      if (strcmp(version, token) == 0) {
        printf("You have the latest Zen version yay \\o/\n");
        return 0;
      }
      result = install_zen(latest_version);
      if (result == -1) {
        return 1;
      }
      printf("Zen has been updated to %s successfully!",
             latest_version->tag_name);
      return 0;
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
