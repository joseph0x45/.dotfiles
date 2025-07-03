#include "common.h"
#include <asm-generic/errno.h>
#include <bits/getopt_core.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define UPDATE_URL                                                             \
  "https://app-versions-three.vercel.app/api/versions?name=teams"
#define TEAMS_PATH "/home/joseph/.local/teams"
#define GET_API_DATA_URL "curl " UPDATE_URL
#define SET_TEAMS_EXECUTABLE "chmod +x " TEAMS_PATH
#define GET_VERSION_CMD TEAMS_PATH " --version 2>&1 | tail -n 1 | tr -d '\n'"

int get_current_teams_version(char *version) {
  int result = run_command(GET_VERSION_CMD, version, sizeof(version));
  if (result == -1) {
    perror("Error while getting Zen current version:");
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

int main(int argc, char **argv) {
  int opt;
  char version_str[100];
  int result;
  while ((opt = getopt(argc, argv, "viu")) != -1) {
    switch (opt) {
    case 'v':
      result = get_current_teams_version(version_str);
      if (result == EXIT_FAILURE) {
        return EXIT_FAILURE;
      }
      printf("Teams v%s", version_str);
      return EXIT_SUCCESS;
    case 'i':
      printf("Fetching latest Teams version from API\n");
      fflush(stdout);
      LatestVersion *version = get_latest_version_data(GET_API_DATA_URL);
      if (!version) {
        return EXIT_FAILURE;
      }
      result = install(version, TEAMS_PATH, SET_TEAMS_EXECUTABLE, "Teams");
      free(version);
      if (result == EXIT_FAILURE) {
        return EXIT_FAILURE;
      }
      return EXIT_SUCCESS;
    case 'u': {
      printf("Fetching latest version from API\n");
      fflush(stdout);
      LatestVersion *version = get_latest_version_data(GET_API_DATA_URL);
      if (!version) {
        return EXIT_FAILURE;
      }
      result = get_current_teams_version(version_str);
      if (result == EXIT_FAILURE) {
        free(version);
        return EXIT_FAILURE;
      }
      char *version_to_cmp = strdup(version->tag_name + 1);
      if (!version_to_cmp) {
        free(version);
        return EXIT_FAILURE;
      }
      if (strcmp(version_str, version_to_cmp) == 0) {
        free(version);
        free(version_to_cmp);
        printf("You have the latest Teams version yay \\o/\n");
        return 0;
      }
      result = install(version, TEAMS_PATH, SET_TEAMS_EXECUTABLE, "Teams");
      if (result == EXIT_FAILURE) {
        free(version);
        free(version_to_cmp);
        return EXIT_FAILURE;
      }
      printf("Teams has been updated to %s successfully!", version->tag_name);
      free(version);
      free(version_to_cmp);
      return EXIT_SUCCESS;
    }
    default:
      printf("Unrecognized option");
      return EXIT_FAILURE;
    }
  }
  return system(TEAMS_PATH);
}
