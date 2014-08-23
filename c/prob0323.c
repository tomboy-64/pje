#include <stdlib.h>
#include <time.h>
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <pthread.h>

pthread_mutex_t globals_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t print_mutex = PTHREAD_MUTEX_INITIALIZER;

void* worker( void )
{
}

void main( void )
{
	uint32_t seed = time(NULL);
	srand(seed);

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
