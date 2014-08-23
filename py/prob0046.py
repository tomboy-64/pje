#!/usr/bin/env python

import sys
import math

primes = [ 2 ]
squares = [ 1 ]

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
					#print("DEBUG 1:", primes)
					break
		if primes[ len(primes)-1 ] >= x:
			outerDone = True

def nextSquare():
	global squares
	squares += [ pow(len(squares)+1, 2) ]

iterator = 9
found = False

while not found:
	i = 0
	found = True
	if( isPrime(iterator) ):
		found = False
		iterator += 2
		continue
	while( squares[i] < iterator ):
		if( isPrime( iterator - (2 * squares[i]) )):
			found = False
			break

		i += 1
		while( i >= len(squares) ):	# we ran out of squares; produce more
			nextSquare()

	if not found:
		iterator += 2
#	if iterator % 10000 == 1:
#		sys.stdout.write(".")
#		sys.stdout.flush()


print("\nResult:", iterator)
print("len(primes): ", len(primes))
print("len(squares): ", len(squares))
