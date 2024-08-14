#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_BUFFER_SIZE 1024
#define MOD 10

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
  s.index = strtok(buffer, " \t");
  s.name = strtok(NULL, " \t");
  s.audio_driver = strtok(NULL, " \t");
  s.sample_format = strtok(NULL, " \t");
  s.channels = strtok(NULL, " \t");
  s.sample_rate = strtok(NULL, " \t");
  s.state = strtok(NULL, " \t");
  return s;
}

void display_sink(Sink s) {
  printf("Index: %s\n", s.index);
  printf("Name: %s\n", s.name);
  printf("Audio Driver: %s\n", s.audio_driver);
  printf("Sample format: %s\n", s.sample_format);
  printf("Channels: %s\n", s.channels);
  printf("Sample Rate: %s\n", s.sample_rate);
  printf("State: %s\n", s.state);
}

Sink get_running_sink(Sink sinks[], int size) {
  Sink s;
  s.state = "INVALID";
  for (int i = 0; i < size; i++) {
    if (strcmp(sinks[i].state, "RUNNING") == 0) {
      return sinks[i];
    }
  }
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
  char *lines[num_of_sinks];
  Sink sinks[num_of_sinks];
  for (int i = 0; i < num_of_sinks; i++) {
    lines[i] = strtok(NULL, "\n");
  }
  for (int i = 0; i < num_of_sinks; i++) {
    sinks[i] = parse_sink(lines[i]);
  }
  Sink running_sink = get_running_sink(sinks, num_of_sinks);
  if (strcmp(running_sink.state, "INVALID") == 0) {
    printf("No running sink found. Play something to get a sink running\n");
  }
  return 0;
}
