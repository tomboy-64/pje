#include <gmp.h>
#include <stdio.h>

struct point_t
{
	mpq_t x;
	mpq_t y;
};

struct point_t X;

void main()
{
	printf("echo\n");
	mpq_inits(X.x, X.y, '\0');
	printf("echo\n");
}
