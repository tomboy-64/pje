#!/usr/bin/env python

maxi, counter, i = 20, 20, 19
while (i > 1):
	if (counter % i == 0):
		i -= 1
	else:
		if ( maxi >= i ):
						maxi = i
						print(counter, ":", i)
		counter += 20
		i = 20
print( "\n === \n", counter )
