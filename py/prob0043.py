#!/usr/bin/env python

import sys
import math
import itertools

def assemble(x):
	z = ""
	for i in x:
		z += i
	return z

counter = 0
solutions = []

for i in itertools.permutations('0123456789', 10):
	counter += 1
	primes = [ 2, 3, 5, 7, 11, 13, 17 ]
	index = 0
	searched = True
	while searched and index < 7:
		assembled = int(assemble(i[index+1:index+4]))
		if assembled % primes[index] != 0:
			searched = False
		index += 1
	if searched:
		print("\n", assemble(i))
		solutions += [ int(assemble(i)) ]
	if counter % 100000 == 0:
#		print(i)
#		print(assemble(i))
		sys.stdout.write(".")
		sys.stdout.flush()

print("\n", sum(solutions))
