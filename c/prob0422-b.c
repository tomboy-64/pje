#include <limits.h>
#include <gmp.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

pthread_barrier_t next_barrier;

void* next_P(void*);
void* next_m(void*);

void main()
{
	setvbuf(stdout, NULL, _IONBF, 0);

	pthread_t thr[2];
	int* testInt = 0;

	if( pthread_barrier_init( &next_barrier, NULL, 2 ))
	{
		printf("Could not create a barrier.\n");
		exit(-1);
	}

	if( pthread_create( &thr[0], NULL, &next_P, NULL ))
	{
		printf("Could not create thread next_P.\n");
		exit(-1);
	}
	if( pthread_create( &thr[1], NULL, &next_m, NULL ))
	{
		printf("Could not create thread next_m.\n");
		exit(-1);
	}

	int i;
	for(i = 0; i < 2; i++)
	{
		if(pthread_join(thr[i], NULL))
		{
			printf("Could not join thread %d\n", i);
			exit(-1);
		}
	}
}

void* next_P(void *none)
{
	mpq_t test1, test2;
	mpq_inits(test1, test2, '\0');
	mpq_set_ui(test1, 5, 2);
	mpq_set_ui(test2, 2, 5);
	mpq_mul(test1, test1, test2);
	
	printf("This is thread next_P before the barrier.\n");

	pthread_barrier_wait( &next_barrier);

	printf("This is thread next_P after the barrier.\n");
	
	gmp_printf("( %#21Qx | %#23Qx )\n", test1, test2);
}

void* next_m(void *none)
{
        printf("This is thread next_m before the barrier.\n");

        pthread_barrier_wait( &next_barrier);

        printf("This is thread next_m after the barrier.\n");
}

