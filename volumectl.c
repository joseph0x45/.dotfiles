#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_BUFFER_SIZE 1024

typedef struct {
  char *index;
  char *name;
  char *audio_driver;
  char *sample_format;
  char *channels;
  char *sample_rate;
  char *state; // can be "SUSPENDED" "IDLE" or "RUNNING"
} Sink;

Sink parse_sink(char *buffer) {
  Sink s;
  return s;
}

int main(int argc, char **argv) {
  char buffer[MAX_BUFFER_SIZE];
  FILE *pipe =
      popen("pactl list sinks short | wc -l && pactl list sinks short", "r");
  if (pipe == NULL) {
    perror("popen failed");
    return 1;
  }
  int read = fread(buffer, 1, MAX_BUFFER_SIZE, pipe);
  if (read == 0) {
    // handle stuff
    pclose(pipe);
    return 0;
  }
  int status = pclose(pipe);
  if (status == -1) {
    perror("pclose failed");
    return 1;
  }
  int exit_status;
  if (WIFEXITED(status)) {
    exit_status = WEXITSTATUS(status);
  } else {
    return 1;
  }
  if (exit_status != 0) {
    fprintf(stderr, "Failed to retrieve list of sinks: %s", buffer);
    return 1;
  }
  int num_of_sinks = atoi(strtok(buffer, "\n"));
  Sink sinks[num_of_sinks];
  char *token;
  while ((token = strtok(NULL, "\n")) != NULL) {
    char *t = strtok(token, " ");
  }
  return 0;
}
