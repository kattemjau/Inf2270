#include <stdio.h>
typedef unsigned char byte;

int main(int argc, char const *argv[]) {
  FILE *file = fopen("test.txt", "wrb"); //create new file
  byte *bit;

  fread(bit, 1, 1, file);    //writes to file
  printf("%x\n",&bit );
  fclose(file);

  return 0;
}
