#!/usr/bin/env python

import sys
import math

iters = 1001
matrix = [ [1] ]
def mat(matrix):
	maxi = 4
	for i in matrix:
		for j in i:
			for k in range(maxi-len(str(j))):
				sys.stdout.write(" ")
			sys.stdout.write(str(j) + ", ")
		print()

n = 1
while n < iters:
	n += 2
	counter = matrix[0][n-3]
	matrix = matrix + [[]]
	for i in range(n-1):
		counter += 1
		matrix[i] += [ counter ]
	for i in range(n-2):
		counter += 1
		matrix[n-2] = [ counter ] + matrix[n-2]
	matrix = [[]] + matrix
	for i in range(n):
		counter += 1
		matrix[n-1-i] = [ counter ] + matrix[n-1-i]
	for i in range(n-1):
		counter += 1
		matrix[0] += [ counter ]
	sys.stdout.write(".")
	sys.stdout.flush()
#	mat(matrix)

summ = 0
sum1, sum2 = [], []
for i in range(iters):
	summ += matrix[i][i]
	sum1 += [ matrix[i][i] ]
	summ += matrix[iters-1-i][i]
	sum2 += [ matrix[iters-1-i][i] ]

print(summ-1)
#print(sum1, sum2)
