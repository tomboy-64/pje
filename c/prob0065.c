#include <gmp.h>

mpq_t result;

void main()
{
	int i;
	mpq_t tq1, tq2;
	mpq_inits(result, tq1, tq2, '\0');
	mpq_set_ui( tq2, 2, 1 );
	mpq_set_ui( tq1, 1, 1 );

	for (i=99; i >= 0; i--)
	{
		mpq_set_ui( tq2, 2, 1 );
		if( i == 0 )
		{
			mpq_add( result, result, tq2 );
		} else {
			if( (i+1) % 3 == 0 )
			{
				mpz_mul_ui( mpq_numref(tq2), mpq_numref(tq2), (i+1)/3 );
				mpq_add( result, result, tq2 );
			} else {
				mpq_add( result, result, tq1 );
			}
			mpq_inv( result, result );
		}
		gmp_printf("%d: %Qd\n", i, result );
	}

	gmp_printf( "Result: %Qd\n\n", result );

	mpz_t tmpz, tmpz2;
	mpz_init_set_ui(tmpz, 0);
	mpz_init_set_ui(tmpz2, 0);
	while( mpz_cmp_ui(mpq_numref(result), 0) > 0 )
	{
		mpz_tdiv_qr_ui( mpq_numref(result), tmpz2, mpq_numref(result), 10 );
		mpz_add( tmpz, tmpz, tmpz2 );
	}


	gmp_printf( "  %Zd\n", tmpz );
}
