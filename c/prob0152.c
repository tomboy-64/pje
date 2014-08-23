#include <gmp.h>
#include <stdio.h>
#include <math.h>
#include <pthread.h>

#define THREADS 4

mpq_t summer[81];
int hit_counter = 0;
int status[80] = {10, 2, 3, 4, 5, 6, 7, 8, 9, 10};
/* [0] # of fractions added (starting with 2)
 * [1] 1st squared number (e.g. 2, 3, 4...)
 * [2] 2nd ...
 *
 */

pthread_mutex_t print_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t status_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t counter_mutex = PTHREAD_MUTEX_INITIALIZER;

void* worker( void* );

void main (void)
{
	setvbuf(stdout, NULL, _IONBF, 0);

	int i;
	for ( i=0; i<=80; i++ )
	{
		mpq_init(summer[i]);
		if ( i>=2 )
		{
			mpq_set_ui(summer[i], 1, pow(i, 2));
//			gmp_printf("%2d: %Qd, 0x%x\n", i, summer[i], &summer[i]);
		}
	}

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

}

void* worker( void *none )
{
// do not break this apart from here
	pthread_mutex_lock(&status_mutex);
	while ( status[0] < 80 )
	{
		int i;

		for ( i = status[0] -1; i > 0; i-- )
		{
			if( (status[i] < 81 - i) && i != 1 )
			{
				status[i]++;
				break;
			}
			else if( (status[i] >= 80 - i) && i != 1 )
			{
				status[i] = status[i-1] + 2;
			}
			else if ( status[i] == 79 )
			{
				status[i] 
				printf("length: %d, main: %d, hit count: %d", status[0], status[1], hit_counter);
			else {
				status[i] = status[i-1] + 1;
			}
		}
		pthread_mutex_unlock(&status_mutex);
// to here


// do not break this apart from here
		pthread_mutex_lock(&status_mutex);
	}
	pthread_mutex_unlock(&status_mutex);
// to here
}
