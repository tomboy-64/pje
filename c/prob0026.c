#include <limits.h>
#include <gmp.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

void main()
{
	unsigned int lengths[1000];
	int i;
	struct nums
	{
		int number;
		mpz_t mantissa;
		int[] remainders;
		struct nums* next;
	} nums[999];

	for ( i=0; i<1000; i++ )
	{
		lengths[i] = 1;
	}
}
