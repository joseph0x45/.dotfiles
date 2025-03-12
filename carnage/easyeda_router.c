#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main() {
  pid_t pid = fork();
  if (pid < 0) {
    perror("Fork failed");
    return 0;
  }
  if (pid == 0) {
    if (chdir("/home/joseph/Downloads/easyeda-router-linux-x64-v0.8.11/") !=
        0) {
      perror("chdir");
      exit(EXIT_FAILURE);
    }
    execl("/bin/sh", "sh",
          "/home/joseph/Downloads/easyeda-router-linux-x64-v0.8.11/lin64.sh",
          (char *)NULL);
    perror("Failed to run router");
    exit(EXIT_FAILURE);
  } else {
    wait(NULL);
  }
  return 0;
}
