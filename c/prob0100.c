#include <math.h>
#include <gmp.h>
#include <time.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define THREADS 4

time_t myTime;

mpz_t x, y, tcnt;
bool result = false;

pthread_mutex_t numbers_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t print_mutex = PTHREAD_MUTEX_INITIALIZER;

void* worker (void *none)
{
	mpz_t x_priv, y_priv, x_side, y_side, tmpz;
	mpz_inits( x_priv, y_priv, x_side, y_side, tmpz, '\0' );
	for ( ;; )
	{
		if(result) break;

		// read the numbers
		pthread_mutex_lock(&numbers_mutex);
		mpz_set( x_priv, x );
		mpz_add_ui( y_priv, y, 1 );
		mpz_add_ui( y, y, 1 );
		pthread_mutex_unlock(&numbers_mutex);

		pthread_mutex_lock(&print_mutex);
		if( difftime(time(NULL), myTime) > 1 )
		{
			myTime = time(NULL);
			mpz_sub(tmpz, y_priv, tcnt);
			mpz_set(tcnt, y_priv);
			mpz_tdiv_q_2exp( tmpz, tmpz, 10 );
			gmp_printf("\rX: %Zd, Y: %Zd, rate: %Zd k/sec", x_priv, y_priv, tmpz);
		}
		pthread_mutex_unlock(&print_mutex);

		mpz_set(x_side, x_priv );
		mpz_set(y_side, y_priv );
		while( mpz_cmp( x_side, y_side ) < 0 )
		{
			mpz_add_ui( x_priv, x_priv, 1 );
			mpz_mul( tmpz, x_priv, x_priv );
			mpz_sub( tmpz, tmpz, x_priv );
			mpz_mul_2exp( x_side, tmpz, (mp_bitcnt_t) 1 );
			mpz_mul( y_side, y_priv, y_priv );
			mpz_sub( y_side, y_side, y_priv );
		}

		if( mpz_cmp( x_side, y_side ) == 0 )
		{
			pthread_mutex_lock(&print_mutex);
			gmp_printf("\nX: %Zd, Y: %Zd\n", x_priv, y_priv);
			pthread_mutex_unlock(&print_mutex);

			result = true;
			break;
		} else {
			pthread_mutex_lock(&numbers_mutex);
			if( mpz_cmp( x_priv, x ) > 0 )		// set global x to private val
								// global x is smaller
			{
				mpz_sub_ui(x, x_priv, 1 );
			}
			pthread_mutex_unlock(&numbers_mutex);

			pthread_mutex_lock(&print_mutex);
//			printf("x");
			pthread_mutex_unlock(&print_mutex);
		}
	}
}

void main( void )
{
	mpz_init_set_ui( x,     756800000000 );
	mpz_init_set_ui( y,    1070370000000 );
	mpz_init_set( tcnt, y );

	myTime = time(NULL);

	setvbuf(stdout, NULL, _IONBF, 0);

	int i;
	pthread_t thr[THREADS];
	for ( i= 0; i < THREADS; i++ )
	{
		if( pthread_create( &thr[i], NULL, &worker, NULL ))
		{
			printf("Could not create thread %d.\n", i);
			exit(-1);
		}
	}

	for(i = 0; i < THREADS; i++)
	{
		if(pthread_join(thr[i], NULL))
		{
			printf("Could not join thread %d.\n", i);
			exit(-1);
		}
	}
	printf("\nResult: %d\n", result);

}
