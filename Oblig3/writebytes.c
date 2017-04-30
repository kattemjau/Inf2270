#include <stdio.h>
typedef unsigned char byte;
typedef unsigned long unicode;

int main(int argc, char const *argv[]) {
  FILE *file = fopen("test.txt", "w+,ccs=UTF-8"); //create new file
  unicode u[] = { 0x24, 0x20, 0x41, 0x3d, 0x32, 0x78 };  // printf("Writnig to file\n");
  byte bit[] = { '$', ' ', 'A', '=', '2', 'x' };


  // fwrite(&u, sizeof(unicode), 1, file);
  fread(bit, 1, 1, file);    //writes to file
  printf("%x\n",&bit );
  fclose(file);

  return 0;
}
