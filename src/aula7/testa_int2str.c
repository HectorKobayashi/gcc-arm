#include <stdio.h>
					
extern int int2str(int a, char* b);
					
int main()
{
	int a = 10262700;
	char b[16];
    int2str(a,b);
	puts(b);
	return (0);
}