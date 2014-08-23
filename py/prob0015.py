#!/usr/bin/env python

import sys

def check(x):
	ctr = 0
	for i in range(len(x)):
		if x[i] == "1":
			ctr += 1
	return ctr

hasOnes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

for i in range(0b100000000000000000000):
	hasOnes[check(bin(i))] += 1
	if i % 100000 == 0:
		sys.stdout.write(".")
		sys.stdout.flush()

print("\n", hasOnes)

combos = []
for i in range(0, 21):
	combos += [ hasOnes[i] * hasOnes[20-i] ]

print(combos, sum(combos))
