#include "common.h"
#include <bits/getopt_core.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>

#define UPDATE_URL                                                             \
  "https://app-versions-three.vercel.app/api/versions?name=teams"
#define TEAMS_PATH "/home/joseph/.local/teams"
#define GET_API_DATA_URL "curl " UPDATE_URL
#define SET_TEAMS_EXECUTABLE "chmod +x " TEAMS_PATH

// int get_current_teams_version(char *version) { return 0; }

int main(int argc, char **argv) {
  int opt;
  while ((opt = getopt(argc, argv, "viu")) != -1) {
    switch (opt) {
    case 'v':
      return EXIT_SUCCESS;
    case 'i':
      printf("Fetching latest Teams version from API\n");
      fflush(stdout);
      LatestVersion *version = get_latest_version_data(GET_API_DATA_URL);
      if (!version) {
        return EXIT_FAILURE;
      }
      return install(version, TEAMS_PATH, SET_TEAMS_EXECUTABLE, "Teams");
    case 'u':
      return EXIT_SUCCESS;
    default:
      printf("Unrecognized option");
      return EXIT_FAILURE;
    }
  }
  return 0;
}
