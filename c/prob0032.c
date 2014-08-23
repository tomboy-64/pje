#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

#define TARGET 500000
#define THREADS 4

unsigned int counter = 1;
unsigned int result = 0;
pthread_mutex_t counter_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t result_mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t print_mutex = PTHREAD_MUTEX_INITIALIZER;

bool is_pandig( int* );
bool is_pandig2( int*, int* );
bool is_pandig3( int*, int*, int* );
void* worker( void* );

void main(void)
{
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

void* worker( void *none )
{
	int theSqrt, i, j;
	for( ;; )
	{
		pthread_mutex_lock(&counter_mutex);
		if(++counter >= TARGET)
		{
			pthread_mutex_unlock(&counter_mutex);
			return;
		}
		unsigned int checkThis = counter;
		pthread_mutex_unlock(&counter_mutex);
		
		if( checkThis % 2500 == 0 )
		{
			pthread_mutex_lock(&print_mutex);
			printf(".");
			pthread_mutex_unlock(&print_mutex);
		}

		if(is_pandig(&checkThis))
		{
			theSqrt = sqrt(checkThis);
			for( i=1; i<=theSqrt; i++ )
			{
				if(( checkThis % i == 0 ) && ( is_pandig2( &i, &checkThis )))
				{
					j=checkThis / i;
					if( is_pandig3( &i, &j, &checkThis ))
					{
						pthread_mutex_lock(&result_mutex);
						result = result + checkThis;
						pthread_mutex_unlock(&result_mutex);
						pthread_mutex_lock(&print_mutex);
						printf("\n%d x %d = %d", i, j, checkThis);
						pthread_mutex_unlock(&print_mutex);
						break;
					}
				}
			}
		}
	}
}

bool is_pandig( int* testor )
{
	bool test_array[10];
	int i, j, k;
	for( i=0; i<=9; i++ )
		test_array[i] = false;
	test_array[0] = true;

	k = *testor;
	while( k > 0 )
	{
		i = k % 10;
		if( test_array[i] )
			return false;
		else
			test_array[i] = true;
		k = k / 10;
	}

	return true;
}

bool is_pandig2( int* testor, int* testor2 )
{
	bool test_array[10];
	int i, j, k;
	for( i=0; i<=9; i++ )
		test_array[i] = false;
	test_array[0] = true;

	for( j=0; j<2; j++ )
	{
		if(j == 0)
			k = *testor;
		else
			k = *testor2;

		while( k > 0 )
		{
			i = k % 10;
			if( test_array[i] )
				return false;
			else
				test_array[i] = true;
			k = k / 10;
		}
	}

	return true;
}

bool is_pandig3( int* testor, int* testor2, int* testor3 )
{
	bool test_array[10];
	int i, j, k;
	for( i=0; i<=9; i++ )
		test_array[i] = false;
	test_array[0] = true;

	for( j=0; j<3; j++ )
	{
		if(j == 0)
			k = *testor;
		else if(j == 1)
			k = *testor2;
		else
			k = *testor3;

		while( k > 0 )
		{
			i = k % 10;
			if( test_array[i] )
				return false;
			else
				test_array[i] = true;
			k = k / 10;
		}
	}

	if( test_array[1] && test_array[2] && test_array[3] && test_array[4] && test_array[5] && test_array[6] && test_array[7] && test_array[8] && test_array[9] )
	{
		return true;
	} else {
		return false;
	}
	return true;
}
