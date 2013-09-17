#include <stdio.h>

int fac(int param)
{
	if ( param < 1 ) {
		return 1;
	} else {
		return param * fac(param-1);
	}
}


int main(void)
{
	printf("%d", fac(10));
}
