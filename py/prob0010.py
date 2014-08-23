#!/usr/bin/env python

import math

primes = [ 2 ]
i = 3

def isPrime(x):
	boundary = int(math.sqrt(x))
	for j in primes:
#		print(x, j, boundary)
		if (x % j == 0):
			return False
		elif (j >= boundary):
			return True

while i < 2000000:
	if isPrime(i):
		primes += [ i ]
		print(len(primes), ":", i )
	i += 2


print("\n", sum(primes))
