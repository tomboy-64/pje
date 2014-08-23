#!/usr/bin/env python

import sys
import math
import itertools

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
#	sys.stdout.write(".")
#	sys.stdout.flush()
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

for i in range(1000, 9999):
	if isPrime(i):
#		sys.stdout.write(str(i))
#		sys.stdout.flush()
		counter = 0
		doublecheck = []
		nextTest = []
		for j in itertools.permutations(str(i), 4):
			z = ''
			for k in j:
				z += k
			z = int(z)
			if j in doublecheck:
				continue
			doublecheck += [ (j[:]) ]
			if isPrime(z) and z > 1000:
#				if(z!=i):
#					sys.stdout.write(" - " + str(z))
#					sys.stdout.flush()
				nextTest += [ z ]
#		sys.stdout.write("\n")
		if( len(nextTest) >= 3 ):
			nextTest.sort()
			differences = dict()

			for j in itertools.combinations(nextTest, 2):
				if abs(j[0]-j[1]) not in differences:
					differences[abs(j[0]-j[1])] = []
				differences[abs(j[0] - j[1])] += [j[0], j[1]] 
			for j in iter(differences):
				if len(differences[j]) > 2:
					for k in differences[j]:
						if differences[j].count(k) > 1:
							print(j, ":", differences[j])
#							exit()

