#!/usr/bin/env python

import sys
import math

primes = [ 2, 3, 5, 7, 11 ]

def isPrime(x):
	if x > primes[ len(primes)-1 ]:
		nextPrimes(x)
	if x in primes:
		return True
	else:
		return False

def nextPrimes(x):
	global primes
	outerDone = False
	sys.stdout.write(".")
	sys.stdout.flush()
	while not outerDone:
		innerDone = False
		i = primes[ len(primes)-1 ]
		while not innerDone:
			i += 1
			maxTest = int( math.sqrt(i) )
			for j in primes:
				if i % j == 0:
					break
				if maxTest <= j:
					innerDone = True
					primes += [ i ]
					# print("DEBUG 1:", primes)
					break
		if primes[ len(primes)-1 ] >= x:
			outerDone = True

#        a, b, n
maxi = [ 0, 0, 0 ]
for a in range(-999,1000):
	for b in range(-999,1000):
		n = 0
		X = n**2 + (a*n) + b
		while isPrime( X ):
			n += 1
			X = n**2 + (a*n) + b
		if maxi[2] < n:
			maxi = [ a, b, n ]
		if n >= 10:
			sys.stdout.write("\n{a b n}: { " + str(a)+" "+str(b)+" "+str(n) + " }")
#	sys.stdout.write(" " + str(a) + " ")
#	sys.stdout.flush()

print("\nResult:", maxi[0]*maxi[1], maxi)
print("len(primes): ", len(primes))
