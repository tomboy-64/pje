#include <gmp.h>
#include <stdbool.h>
#include <stdio.h>

#define NUMBER 9

unsigned long sum ( x ):
	unsigned long result;
	int i;
	for (i=1; i<=x; i++)
	{
		result += i;
	}
	return result;

unsigned long init ( x ):
	unsigned long result;
	result = sum(x-1) + 1;
	return result;

void main(void)
{
	unsigned long int excerpt[5][NUMBER+2]
	int i, j;

	for (i=-2; i<=2; i++)
	{
		for (j=0; j<NUMBER+2; j++)
		{
			:q
}
