#include <stdio.h>
typedef unsigned char byte;

int main(int argc, char const *argv[]) {
  FILE *file = fopen("test.txt", "wrb"); //create new file
  byte bit = 4;

  fwrite(&bit, 1, 1, file);    //writes to file
  fclose(file);

  return 0;
}
