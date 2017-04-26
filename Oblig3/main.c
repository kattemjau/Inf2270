#include <stdio.h>
#include <wchar.h>
#include <stdlib.h>

// #include <sys/cdefs.h>
// #include <stdout.h>

typedef unsigned char byte;
typedef unsigned long unicode;

extern int  readbyte (FILE *f);
extern long readutf8char (FILE *f);
extern void writebyte (FILE *f, byte b);
extern void writeutf8char (FILE *f, unicode u);

int main() {
  printf("Creating file\n");
  FILE *file = fopen("test.txt", "w+");
  byte bit = 5;
  printf("Writnig to file\n");
  writebyte(file, bit);

  printf("Reading from file: %s\n",readbyte(file));


  printf("Closing file\n");
  fclose(file);
  return 0;
}
