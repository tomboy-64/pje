#include <stdint.h>
#include <stdio.h>

#define SEARCH 10000000

int target = 100;

uint8_t table[SEARCH];

int ind (int a, int b) {
	return ((a-3)*(a-2)/2)+b-1;
}

uint8_t e (int a, int b) {
	int idx = ind(a,b);

	if (a==b || b==1) {
		return 1;
	} else {
		int x;
		x = a%b;
		if (b>a)
			return e(b,x) + 1;
		if (idx < SEARCH) {
			if (table[idx] == 0)
				table[idx] = table[ind(b,x)] + 1;
			return table[idx];
		} else {
			return e(b,x) + 1;
		}
	}
}

uint64_t sumOfRow (uint32_t row) {
	uint64_t result = 0;
	uint32_t intermed = 0;
	uint8_t c;
	int a,b;
	for (a=1; a<=row; a++)
	{
		intermed = 0;
		for (b=1; b<a; b++)
		{
//			printf("%d ", c);
			intermed += e(a,b);
		}
//		printf("\n");
		result += (intermed*2) + row + 1;
	}
	return result;
}

void main (void) {
	printf("\nResult: %lu\n", sumOfRow(100));
	int i,j,z;
	z = 7;
	for (j=1; j<=z; j++)
		printf("\n(%d,%d): %d",z,j, e(z,j));
	for (j=1; j<=z; j++)
		printf("\n(%d,%d): %d",j,z, e(j,z));
}
