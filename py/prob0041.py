#!/usr/bin/env python

import sys
import math
import itertools
import gmpy2

def assemble(x):
	z = ""
	for i in x:
		z += i
	return z

biggest = 0
counter = 0

for i in range(1, 11):
	for j in itertools.permutations('0123456789', i):
		num = int(assemble(j))
		test = gmpy2.is_prime(num,100)
		if test:
			if num > biggest:
				biggest = num
				print("New biggest:", num)
			else:
				print(num, test)

print("\n\nDone.")

