#!/usr/bin/env python

import sys

def penta(n):
	result = n*((3*n)-1)/2
	return int(result)

pentas = [ 0, penta(1), penta(2) ]

sums, diffs = [[0], [1]], [[0], [1]]

D = 10000000
Dpot = []

while (pentas[len(pentas)-1] - pentas[len(pentas)-2] < D) or (len(Dpot) > 0) or (D == 0):
# abbreviation
	ind = len(pentas)
# next element of pentas, sums and diffs
	pentas += [ penta(ind) ]
	sums = [ 0 ]
	diffs = [ 0 ]

# here the next element for diffs and sums are computed
	for i in range(1, ind):
		diffs += [ pentas[ind] - pentas[i] ]
		sums += [ pentas[ind] + pentas[i] ]
	
# is an element of our (just computed) diffs in pentas - and that element is smaller than D
# Dpot gets a new member
	for i in range(1, len(diffs)):
		if (pentas.count(diffs[i]) == 1) and (diffs[i] < D):
			Dpot += [[diffs[i], sums[i]]]
			sys.stdout.write("\nPotential hit: " + str(ind) + " " + str(i) + " " + str(Dpot[len(Dpot)-1]) + " " + str(len(Dpot)) + " ")
			sys.stdout.flush()

	i = 0
	while(i < len(Dpot)):
# Do we have a hit?
# Dpot[1] contains the sums we stored before.
		accepted_hit = False
		if pentas.count(Dpot[i][1]) == 1:
			sys.stdout.write("\nHit: " + str(Dpot[i]))
# We can accept it only if our previous D is bigger than our hit.
			if D > Dpot[i][0]:
				D = Dpot[i][0]
				sys.stdout.write(" ... accepted. ")
# Our shit got accepted, now filter out all diffs that are smaller.
				accepted_hit = True
			else:
				sys.stdout.write(" ... discarded. ")
# Here the element is dropped from the list.
			sys.stdout.flush()
			del Dpot[i:i+1]
# Here we filter out the potential sums that already got too small to be hit.
		elif Dpot[i][1] < pentas[ind]:
			sys.stdout.write(":")
			sys.stdout.flush()
			del Dpot[i:i+1]
# Only if no element was deleted from Dpot can our index be safely increased
		else:
			i += 1

		if accepted_hit:
			j = 0
			while j < len(Dpot):
				if Dpot[j][0] < D:
					del Dpot[j:j+1]
					sys.stdout.write(":")
					sys.stdout.flush()
				j += 1
			accepted_hit = False
			print("\nActually, the problem is solved here. Though I can't prove D is actually minimal, Euler accepts this.")
	print("\n", D)
exit()
