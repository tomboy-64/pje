#!/usr/bin/env python

def collatz(n):
	if n % 2 == 0:
		return n/2
	else:
		return (3*n)+1

maxi = 0
for i in range(1, 1000000):
	sequence = []
	col = i
	while col != 1:
		sequence += [ col ]
		col = collatz(col)
	sequence += [1]
	if (maxi < len(sequence)):
		maxi = len(sequence)
		print(i, ":", maxi)


