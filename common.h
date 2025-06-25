#define _POSIX_C_SOURCE 200809L
#include <linux/limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
