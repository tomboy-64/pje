import math
import gmpy2

LINE_NO = [ 8, 9, 10000, 5678027, 7208785]

primes = [ 2 ]

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
#       sys.stdout.write(".")
#       sys.stdout.flush()
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


def has_neighbours( length, testor, first, second, previous ):
	results = []
	for i in range(testor - length, testor - length + 3):
		if i in first and (not i in previous):
			results += [[1, i]]
	for i in range(testor + length - 1, testor + length + 2):
		if i in second and (not i in previous):
			results += [[2, i]]
	return results

for i in LINE_NO:
	searchprimes = []
	targets = []
	for j in range(i-2, i+3):
		searchprimes += [[]]
		for k in range(sum(range(j)) + 1, sum(range(j)) + 1 + j):
			if gmpy2.is_prime( k ):
				searchprimes[len(searchprimes)-1] += [ k ]
	
#	print( str(i) + ":", searchprimes )

	for j in searchprimes[2]:
#		print(has_neighbours( i, j, searchprimes[1], primes[3], [ j ] ))
		for chk_neighbours in has_neighbours( i, j, searchprimes[1], searchprimes[3], [ j ] ):
			if chk_neighbours[0] == 1:
				chk_neighbours = has_neighbours( i-1, chk_neighbours[1], searchprimes[0], searchprimes[2], [j, chk_neighbours[1]] )
			elif chk_neighbours[0] == 2:
				chk_neighbours = has_neighbours( i+1, chk_neighbours[1], searchprimes[2], searchprimes[4], [j, chk_neighbours[1]] )
			if len(chk_neighbours) > 0:
				targets += [ j ]
				break
#	print( str(i) + ":", targets )
	print( str(i) + " (sum):", sum(targets) )
#	print(searchprimes[2][0] - searchprimes[2][len(searchprimes[2])-1])
