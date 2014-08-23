#!/usr/bin/env python

import itertools

A = itertools.permutations('0123456789',10)
print(".")
B = []
for i in A:
	B += [ i ]
print(".")
C = []
for i in B:
	C += [ "" ]
	for j in i:
		C[len(C)-1] += str(j)
print(".")
C.sort()

print(C[999999])