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
extern char writeutf8char (FILE *f, unicode u);

int main() {
  printf("Creating file\n");
  FILE *file = fopen("test.txt", "w+rb");
  byte bit[] = { '$', ' ', 'A', '=', '2', 'x' };
  unicode u[] = { 0x24, 0x20, 0x41, 0x3d, 0x32, 0x78 };  // printf("Writnig to file\n");
  // writebyte(file, bit[0]);

  // printf("Reading from file: %x\n",readbyte(file));

  printf("writeing unicode %x\n",  writeutf8char(file, u[0]));


  fclose(file);
  return 0;
}
