#define __STDC_FORMAT_MACROS
#include <inttypes.h>
#include <time.h>
#include <stdint.h>
#include <stdio.h>

void main (void)
{
	uint64_t counter[64];
	uint32_t randval;
	uint32_t seed = time(NULL);
	srand(seed);
	int i;
	uint64_t ctr = 0;

	for ( ;; )
	{
		ctr++;

		randval = rand();
		for ( i=0; i<32; i++ )
		{
			if (randval % 2 == 1)
				counter[i]++;
			else
				counter[32+i]++;
			randval >>= 1;
		}

		if (ctr % 1000000 == 5)
		{
			printf("\r%lu: ", ctr);
			for ( i=0; i<32; i++ )
			{
				printf("%li ", counter[i]-counter[32+i]);
			}
		}
	}
}

