#include <stdio.h>

int mostra;

extern int int2str(int a, char* b);

int main(){
    char *string;
    __asm ("MOV r3, %[mostra_address]\n\t"
            "MOV r2, #1\n\t"
            "STR r2, [r3]"
    : 
    : [mostra_address] "r" (&mostra)
  );
    int2str(mostra, string);
    puts(string);
    return 0;
}
