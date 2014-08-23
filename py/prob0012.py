#!/usr/bin/env python

import math
import sys

primes = [ 2 ]
triangle = 1
divisors = []
maxi, ind = 0, 0

while (len(divisors) < 500):
	divisors = []
	trisum = sum(range(triangle + 1))
	triangle += 1

	multFlip = int(math.sqrt(trisum))
	for i in range(1, multFlip+1):
		if (trisum % i == 0):
			divisors += [ i, trisum/i ]

	if (len(divisors) > maxi):
#		if (len(divisors) < 500):
		sys.stdout.write("\n" + str(triangle) + " : " + str(trisum) + " : " + str(len(divisors)) + " " )
		maxi = len(divisors)
		ind = 0
	else:
		if ind < 25:
			sys.stdout.write(".")
			ind += 1
		elif ind < 50:
			sys.stdout.write("\b \b")
			ind += 1
		else:
			ind = 0

		sys.stdout.flush()
