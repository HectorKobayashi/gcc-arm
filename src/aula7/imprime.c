#include <stdio.h>

extern int int2str(int a, char* b);

void imprime(N) {
  if (N<0) {
    return;
  }
  puts("numero = ");
  char *b;
  int2str(N, b);
  puts(b);
  imprime(N-1);
}


int main(void ) {
     imprime(5);
     return 0;
}
