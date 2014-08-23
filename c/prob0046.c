#include <math.h>



typedef struct DATA {
	unsigned long number;
};

typedef struct dyn_array {
	unsigned long *the_array = NULL;
	int	num_elements = 0; // Keeps track of the number of elements used
	int	num_allocated = 0; // This is essentially how large the array is
}

int AddToArray (unsigned long item, dyn_array *array)
{
	if( *array.num_elements == *array.num_allocated ) // Are more refs required?
	{ 
		if ( *array.num_allocated == 0 )
			*array.num_allocated = 1000;
		else
			*array.num_allocated += 2000;

		// Make the reallocation transactional 
		// by using a temporary variable first
		void *_tmp = realloc( *array.the_array, ( *array.num_allocated * sizeof( unsigned long )));

		// If the reallocation didn't go so well,
		// inform the user and bail out
		if (!_tmp)
		{
			fprintf(stderr, "ERROR: Couldn't realloc memory!\n");
			return(-1);
		}

		// Things are looking good so far
		*array.the_array = (unsigned long*)_tmp;
	}

	*array.the_array[*array.num_elements] = item;
	*array.num_elements++;

	return *array.num_elements;
}

dyn_array Primes;
dyn_array Squares;



void main( void )
{
	int i;

	for( i=0; i<2000; i++ )
	{
		
	}
}
