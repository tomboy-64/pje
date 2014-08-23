#include <gmp.h>
#include <math.h>
#include <stdbool.h>

void main(void)
{
	unsigned int iterator, hitCtr;
	hitCtr = 0;
	int size = 1;
	unsigned int j, k;
	bool allPrimes;
	mpz_t tmp;
	mpz_init(tmp);

	for( iterator = 2; iterator < 1000000; iterator++ )
	{
		if( pow( 10, size ) <= iterator ) size++;
		
		unsigned long int store[size];
		allPrimes = true;
		for( j = 0; j < size; j++ )
		{
			k = iterator % (unsigned int) pow(10,j);
			mpz_set_ui( tmp, iterator / (unsigned int) pow(10, j) );
			mpz_add_ui( tmp, tmp, ( k ) * (unsigned int) pow( 10, size-j ) );
			if( mpz_probab_prime_p(tmp, 100) == 0 )
			{
				allPrimes = false;
			}
			store[j] = mpz_get_ui(tmp);
		}
		if( allPrimes ) 
		{
			hitCtr++;
			gmp_printf("\n");
			for( j=0; j<size; j++ )
				gmp_printf(" : %d ", store[j]);
		}
		
	}
	gmp_printf("\n\n   Result: %d\n", hitCtr);
}	
