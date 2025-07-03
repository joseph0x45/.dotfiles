#define _POSIX_C_SOURCE 200809L
#include <linux/limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char *tag_name;
  char *download_url;
} LatestVersion;

int run_command(const char *cmd, char *output, size_t maxlen) {
  FILE *fp;
  char buffer[128];
  if (!output || maxlen == 0) {
    return -1;
  }
  output[0] = '\0';
  fp = popen(cmd, "r");
  if (!fp) {
    return -1;
  }
  while (fgets(buffer, sizeof(buffer), fp) != NULL) {
    size_t space_left = maxlen - strlen(output) - 1;
    if (space_left == 0) {
      break;
    }
    strncat(output, buffer, space_left);
  }
  pclose(fp);
  return 0;
}

int download(const char *url, const char *destination) {
  char command[PATH_MAX];
  snprintf(command, sizeof(command), "wget -O %s %s", destination, url);
  return system(command);
}

LatestVersion *get_latest_version_data(const char *api_url) {
  LatestVersion *version = malloc(sizeof(LatestVersion));
  if (!version) {
    return NULL;
  }
  char api_data[2048];
  int result = run_command(api_url, api_data, sizeof(api_data));
  if (result == -1) {
    perror("Error while querying API");
    return NULL;
  }
  char *token = strtok(api_data, " ");
  version->tag_name = strdup(token);
  token = strtok(NULL, " ");
  version->download_url = strdup(token);
  return version;
}

int install(LatestVersion *version, const char *path, const char *exec_cmd,
            const char *app_name) {
  printf("Downloading %s %s\n", app_name, version->tag_name);
  fflush(stdout);
  int result = download(version->download_url, path);
  if (result == -1) {
    fprintf(stderr, "Error while downloading latest %s version: ", app_name);
    perror("");
    return EXIT_FAILURE;
  }
  printf("Done!\n");
  printf("Installing %s %s to %s\n", app_name, version->tag_name, path);
  result = system(exec_cmd);
  if (result == -1) {
    fprintf(stderr, "Error while setting %s to be executable", app_name);
    perror("");
    return EXIT_FAILURE;
  }
  printf("%s installed \\o/", app_name);
  return EXIT_SUCCESS;
}
