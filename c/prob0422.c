/*
 * counter represents the iterations this program has run.
 * MAX_LOOPS is 11^14. That's the supposed goal. You won't reach it
 *   in your lifetime with stock number crunching.
 * MODULATOR is 1'000'000'007 - the modulator for the final sum.
 * P_j.x and P_j.y are both of type mpq_t; it represents P_n for
 *   n = counter. Use gmp_printf() to get meaningful output.
 *
 * The whole program is very fragmented and tries to utilize several
 *   threads to facilitate parallel computing in a clumsy fashion.
 * Note to self: next time use a language that isn't a total cunt
 *   about parallel computation.
 *
 * */


#include <limits.h>
#include <gmp.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

#define MAX_LOOPS 379749833583241
#define MODULATOR 1000000007

#define BARRIERS 4
pthread_barrier_t barriers[BARRIERS];

#define THREADS 5
void* next_V(void*);
void* ztage1(void*);
void* rc_a(void*);
void* rc_b(void*);
void* rc_c(void*);

void global_init(void);

struct point_t
{
	mpq_t x;
	mpq_t y;
} X, P_i, P_j, Vektor;

struct
{
	mpq_t vw, v24, w24, xa, xb, xc, z;
} common;

unsigned long int counter;

void main()
{
	setvbuf(stdout, NULL, _IONBF, 0);
	
	int i;
	mpq_inits(X.x, X.y, P_i.x, P_i.y, P_j.x, P_j.y, Vektor.x, Vektor.y, '\0');
	mpq_inits(common.vw, common.v24, common.w24, common.xa, common.xb, common.xc, common.z, '\0');

	global_init();

	// init my barriers
	int barrier_limits[BARRIERS] = { 4, 3, 3, 2 };
	for ( i = 0; i < BARRIERS; i++ )
	{
		if( pthread_barrier_init( &barriers[i], NULL, barrier_limits[i] ))
		{
			printf("Could not create barrier %d.\n", i);
			exit(-1);
		}
	}

	// using function pointers to create the threads
	pthread_t thr[THREADS];
	void* (*fu[6]) (void*);
	fu[0] = next_V;
	fu[1] = ztage1;
	fu[2] = rc_a;
	fu[3] = rc_b;
	fu[4] = rc_c;
	for ( i= 0; i < THREADS; i++ )
	{
		if( pthread_create( &thr[i], NULL, fu[i], NULL ))
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
}

void* next_V(void *none)
{
	unsigned long div_ctr, i;
	mpz_t modulator, tmpz, tmpz2, tmpz3, tz3, sum;
	mpq_t tmp, tmp2;
	mpf_t percent, total;
	mpz_init_set_ui( modulator, 1000000007 );
	mpz_inits( tmpz, tmpz2, tmpz3, tz3, sum, '\0');
	mpq_init(tmp);
	mpz_set_ui(tz3, 3);
	mpf_init2 (percent, (mp_bitcnt_t) 120);
	mpf_init2 (total, (mp_bitcnt_t) 120);
	mpf_set_ui( total, (unsigned long) MAX_LOOPS );
	for ( ;; )
	{
		mpq_sub( Vektor.x, P_i.x, X.x );
		mpq_sub( Vektor.y, P_i.y, X.y );

		pthread_barrier_wait( &barriers[0] );
		
		mpq_set( P_i.x, P_j.x );
		mpq_set( P_i.y, P_j.y );

		pthread_barrier_wait( &barriers[3] );

		mpq_mul( tmp, common.z, Vektor.x );
		mpq_add( P_j.x, P_j.x, tmp );
		mpq_mul( tmp, common.z, Vektor.y );
		mpq_add( P_j.y, P_j.y, tmp );
		mpq_canonicalize(P_j.x);
		mpq_canonicalize(P_j.y);
		++counter;
//		if( ++counter > 10 ) printf("%lu\n", counter);
//		if( ++counter % 100000 == 8 )
//		{
//			mpf_ui_div( percent, counter, total );
//			gmp_printf( "\r  %.*Ff, %lu", 10, percent, counter );
//		}
//		gmp_printf("counter: %lu, ( %Qd | %Qd )\n", ++counter, P_j.x, P_j.y);
		if( counter == MAX_LOOPS || counter <= 25) 
		{
			mpz_set_ui(sum, 0);
			mpz_mod(tmpz, mpq_numref( P_j.x ), modulator);
			mpz_add(sum, sum, tmpz);
//			gmp_printf("0x%Zx -=- %Zd ::: ", tmpz, tmpz );
			mpz_mod(tmpz, mpq_numref( P_j.y ), modulator);
			mpz_add(sum, sum, tmpz);
//			gmp_printf("0x%Zx -=- %Zd ::: ", tmpz, tmpz );
			mpz_mod(tmpz, mpq_denref( P_j.x ), modulator);
			mpz_add(sum, sum, tmpz);
//			gmp_printf("0x%Zx -=- %Zd ::: ", tmpz, tmpz );
			mpz_mod(tmpz, mpq_denref( P_j.y ), modulator);
			mpz_add(sum, sum, tmpz);
//			gmp_printf("0x%Zx -=- %Zd\n", tmpz, tmpz );
			mpz_mod(sum, sum, modulator);
			if( counter == MAX_LOOPS )
			{
				exit(1);
			} else {
//				gmp_printf("oct( %Qo | %Qo )\n", P_j.x, P_j.y );
//				gmp_printf("dec( %Qd | %Qd )\n", P_j.x, P_j.y );
//				gmp_printf("hex( %Qx | %Qx )\n", P_j.x, P_j.y );
				gmp_printf("counter: %lu\nSolution: %Zd\n", counter, sum);
				gmp_printf("dec( %Zd )\nhex( %Zx )\n", mpq_numref(P_j.y), mpq_numref(P_j.y) );
//				gmp_printf("dec( %Zd )\nhex( %Zx )\n", mpq_denref(P_j.y), mpq_denref(P_j.y) );
			}
			mpz_set( tmpz, mpq_denref(P_j.y) );
			div_ctr = 1;
			mpz_mod_ui( tmpz2, tmpz, 0x10 );
			while( mpz_cmp_ui( tmpz2, 0 ) == 0 )						// /16 = .0?
			{
				mpz_tdiv_q_2exp( tmpz, tmpz, (mp_bitcnt_t) 4 );		// /16
				if(mpz_perfect_power_p(tmpz))				// tmpz = x^n?
				{
/*					for( i=2; i<=32; i++ )
					{
						mpz_rootrem( tmpz3, tmpz2, tmpz, i );		
						if( mpz_cmp_ui( tmpz2, 0 ) == 0 )	// ith root?
						{
						//	gmp_printf("%dth root:   %Zx\n", i, tmpz3);
						//	gmp_printf("%dth root.\n", i, tmpz3);
						}
					}*/
					mpz_pow_ui(tmpz2, tz3, i=2);
					while( mpz_cmp( tmpz, tmpz2 ) >= 0 )
					{
						if( mpz_cmp( tmpz, tmpz2 ) == 0 )
						{
//							gmp_printf(">> by %d * 0x10\n", div_ctr);
//							gmp_printf("3^%d.\n", i);
						}
						mpz_pow_ui(tmpz2, tz3, ++i);
					}
				}
				
				mpz_mod_ui( tmpz2, tmpz, 0x10 );
				div_ctr++;
			}
			gmp_printf(">> by %d * 0x10\n==========\n", div_ctr);
		}
	}
}

void* ztage1(void *none)
{
	mpq_t t24;
	mpq_init( t24 );
	mpq_set_ui( t24, 24, 1 );
	for ( ;; )
	{
		pthread_barrier_wait( &barriers[0] );

		mpq_mul( common.vw, Vektor.x, Vektor.y );
		mpq_mul( common.v24, Vektor.x, t24 );
		mpq_mul( common.w24, Vektor.y, t24 );

		pthread_barrier_wait( &barriers[1] );
	}
}

void* rc_a(void *none)
{
	mpq_t t7, tmp1, tmp2, tmp3;
	mpq_inits( t7, tmp1, tmp2, tmp3, '\0' );
	mpq_set_ui( t7, 7, 1 );
	for ( ;; )
	{
		pthread_barrier_wait( &barriers[0] );
	
		mpq_mul( tmp1, Vektor.x, t7 );
		mpq_mul( tmp2, Vektor.y, t7 );
			
		pthread_barrier_wait( &barriers[1] );

		mpq_sub( tmp1, tmp1, common.w24 );
		mpq_mul( tmp3, tmp1, P_j.y );
		mpq_add( tmp2, tmp2, common.v24 );
		mpq_mul( common.xa, tmp2, P_j.x );
		mpq_add( common.xa, common.xa, tmp3 );

		pthread_barrier_wait( &barriers[2] );
	}
}

void* rc_b(void *none)
{	
	mpq_t t14, tmp1, tmp2;
	mpq_inits( t14, tmp1, tmp2, '\0' );
	mpq_set_ui( t14, 14, 1 );
	for ( ;; )
	{
		pthread_barrier_wait( &barriers[1] );

		mpq_mul( common.xb, common.w24, Vektor.y );
		mpq_mul( tmp1, common.vw, t14 );
		mpq_mul( tmp2, common.v24, Vektor.x );
		mpq_add( tmp1, tmp1, tmp2 );
		mpq_sub( common.xb, common.xb, tmp1 );

		pthread_barrier_wait( &barriers[2] );
	}
}

void* rc_c(void *none)
{
	mpq_t t25, tmp1, tmp2, tmp3;
	mpz_t tmpz1, tmpz2;
	mpq_inits( t25, tmp1, tmp2, tmp3, '\0' );
	mpz_inits( tmpz1, tmpz2, '\0' );
	mpq_set_ui( t25, 25, 1 );
	for ( ;; )
	{
		pthread_barrier_wait( &barriers[0] );
		
		mpq_mul( tmp1, Vektor.x, P_j.y );
		mpq_mul( tmp2, tmp1, tmp1 );		// tmp2 = (v*y)^2
		mpq_mul( tmp1, Vektor.y, P_j.x );
		mpq_mul( tmp3, tmp1, tmp1 );		// tmp3 = (w*x)^2
		mpq_add( tmp2, tmp2, tmp3 );	// tmp2 = (v*y)^2 + (w*x)^2
		mpq_mul( tmp1, P_j.x, P_j.y );		// tmp1 = (x*y)

		pthread_barrier_wait( &barriers[2] );

		mpq_mul( tmp3, common.vw, tmp1 );
		mpq_add( tmp3, tmp3, common.xb );
		mpq_mul_2exp( tmp3, tmp3, (mp_bitcnt_t) 1 );
		mpq_sub( tmp2, tmp2, tmp3 );

		if( mpz_perfect_square_p(mpq_numref(tmp2)) == 0
			|| mpz_perfect_square_p(mpq_denref(tmp2)) == 0 )
		{
			printf("BUG! [rc_c 1]\n");
			exit(-1);
		}

		mpz_sqrt( tmpz1, mpq_numref(tmp2) );
		mpz_sqrt( tmpz2, mpq_denref(tmp2) );
		mpq_set_num( tmp2, tmpz1 );
		mpq_set_den( tmp2, tmpz2 );
		mpq_mul( tmp1, t25, tmp2 );
		mpq_set( tmp2, common.xa );
		mpq_neg( tmp2, tmp2 );
		
		if( mpq_equal( tmp1, tmp2 ) )		// this means, xc - xa == 0
		{
			mpq_sub( tmp1, common.xa, tmp1 );
			mpq_div( common.z, tmp1, common.xb );
		} else if( mpq_equal( tmp1, common.xa ) )
		{
			mpq_add( tmp1, tmp1, common.xa );
			mpq_div( common.z, tmp1, common.xb );
		} else {
			printf("BUG! [rc_c 2]\n");
			exit(-1);
		}
		
		pthread_barrier_wait( &barriers[3] );
	}
}

void global_init(void)
{
	counter = 2;
	mpq_set_ui(X.x, 7, 1);
	mpq_set_ui(X.y, 1, 1);
	mpq_set_ui(P_i.x, 13, 1);
	mpq_set_ui(P_i.y, 61, 4);
	mpq_set_si(P_j.x, -43, 6);
	mpq_set_si(P_j.y, -4, 1);
}
