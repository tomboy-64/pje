#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>

#define TARGET 10000000
#define THREADS 4

unsigned int counter = 0;
unsigned int result = 0;
pthread_mutex_t counter_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t result_mutex = PTHREAD_MUTEX_INITIALIZER;

void* chain( void* );

void main()
{
	setvbuf(stdout, NULL, _IONBF, 0);

	int i;
	pthread_t thr[THREADS];
	for ( i= 0; i < THREADS; i++ )
	{
		if( pthread_create( &thr[i], NULL, &chain, NULL ))
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

void* chain( void *callsign )
{
	unsigned int next, i;
	unsigned int this;
	for ( ;; )
	{
		pthread_mutex_lock(&counter_mutex);
		if( ++counter >= TARGET )
		{
			pthread_mutex_unlock(&counter_mutex);
			return;
		} else this = counter;
		if( counter % 100000 == 99999 )
		{
			printf(".");
		}
		pthread_mutex_unlock(&counter_mutex);

		for ( ;; )
		{
			next = 0;
			while( this > 0 )
			{
				i = this % 10;
				next = next + ( i * i );
				this = this / 10;
			}
			if(next == 1)
			{
				break;
			} else if(next == 89)
			{
				pthread_mutex_lock(&result_mutex);
				result++;
				pthread_mutex_unlock(&result_mutex);
				break;
			}
			this = next;
		}
	}
}
