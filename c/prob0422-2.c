#include <limits.h>
#include <stdio.h>
#include <gmp.h>

int main()
{
	printf("\n");
	printf("GMP Version: %i.%i.%i\n", __GNU_MP_VERSION, __GNU_MP_VERSION_MINOR, __GNU_MP_VERSION_PATCHLEVEL);
	printf("GMP GCC: %s\n", __GMP_CC);
	printf("GMP CFLAGS: %s\n\n\n", __GMP_CFLAGS);
	
	// general variables
	int playItSafe = 1;

	printf("Test: %d", playItSafe);
}
