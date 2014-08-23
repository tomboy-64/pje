#!/usr/bin/env python

import math
import sys

def prpr_divs(x):
	result = [1]
	for i in range(2, int(math.sqrt(x)+1)):
		if x%i == 0:
			result += [ i ]
			if i*i != x:
				result += [ x//i ]
	return result
	
def isPerfect(x):
	if sum(prpr_divs(x)) == x:
		return True
	else:
		return False

def isAbundant(x):
	if sum(prpr_divs(x)) > x:
		return True
	else:
		return False

def isDeficient(x):
	if sum(prpr_divs(x)) < x:
		return True
	else:
		return False

def isAbSummable(x, abundants):
	maxi = 28124
	for j in range(len(abundants)-1):
		if j > 28124//2+1:
			return False
#		elif abundants.count(x-j) == 1:
#			return True
		k = [j, j, ((len(abundants) - j) // 2) + j]
		print(j, k)
		while k[2] != k[1]:
			if j + abundants[k[2]] == x:
				return True
			else:
				k[0], k[1] = k[1], k[2]
				if j + abundants[k[2]] > x:
					k[2] = (k[2] - k[1] - 1) // 2 + k[1]
				elif j + abundants[k[2]] < x:
					k[2] = (len(abundants)-1 - k[2] + 1) // 2 + k[2]
				
				if k[0] == k[2]:
					print("Endless loop for x =", x)
				print(len(abundants), k)

abundants = []
for i in range(1, 28124):
	if i%1000 == 1:
		sys.stdout.write(".")
		sys.stdout.flush()
	if isAbundant(i):
		abundants += [i]

sys.stdout.write(" finished building our list of abundant numbers.\nIt has " + str(len(abundants)) + " members.\n\nChecking their sums now.\n")

notAbSum = []
# i is not an index, it's the number we check here
for i in range(1, 28124):
	if i%1000 == 1:
		sys.stdout.write(".")
		sys.stdout.flush()
# these are indices we loop over.
	j = 0
	while j < len(abundants):
		# now we know this can't be an abundant sum
		if abundants[ j ] + abundants[0] > i:
			notAbSum += [ i ]
			j = len(abundants)
		else:
			k = [0, j, len(abundants)-1]
			while k[1] != k[2]:
				print("x1:", k)
				k[0], k[1] = k[1], k[2]
				print("x2:", k)
				summ = abundants[j] + abundants[k[2]]
				if summ > i:
					k[2] = (k[2]-k[1])//2 + k[1]
				elif summ < i:
					k[2] = (len(abundants)-1 - k[2])//2 + 1 + k[2]
				else: # abundants[ j ] + abundants[ k[2] ] == i:
					# we found an abundant sum, so while k and j will be aborted
					k[1] = k[2]
					j = len(abundants)
					print("hit:", j, "+", k[2], "-=-", abundants[j], "+", abundants[k[2]], "=", i)

				print("k:", k)
				if (abs(k[0]-k[1]) == 1 and abs(k[1]-k[2]) == 1) or (k[2] == k[1]):
					print("no hit:", j, "+", k[2], "-=-", abundants[j], "+", abundants[k[2]], "!=", i)
					k[1] = k[2]

				if k[0] == k[2]:
					print("Endless loop for i =", i)
					exit()
				if k[2] < 0:
					print("k is not supposed to be <0:", k, abundants)
					exit()
				if k[0] - k[1] == k[1] - k[2]:
					print("k moved in the same direction by the same amount twice.", k)
					exit()
		j += 1

sys.stdout.write("\n\nThere are " + str(len(notAbSum)) + " numbers which can be sums of abundant numbers.")
print(sum(notAbSum))
