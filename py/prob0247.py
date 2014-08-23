#!/usr/bin/env python

import itertools

def maxlen(x):
	if len(x) == 7:
		print(x)
	maxi = [ 0, [] ]
	found = [ 0, 0 ]
	for i in range(len(x)-1):
		if x[i] == found[1]:
			found[0] += 1
		else:
			found = [ 1, x[i] ]
		if (found[0] == maxi[0]) and (not (found[1] in maxi[1])):
			maxi[1] += [ found[1] ]
		elif found[0] > maxi[0]:
			maxi = [ found[0], [found[1]] ]
	if len(x) == 7:
		print(maxi)
		
	return maxi

for i in range(1,11):
	myList = list(itertools.repeat(0, i+1))
	LS = 0
	for j in itertools.product(range(1,i+1), repeat=i):
		thisResult = maxlen(j)
		LS += thisResult[0]
		for k in thisResult[1]:
			myList[k] += thisResult[0]
	
	print("\n", i, ":::", LS)
	for j in range(1, i+1):
		print(j, ":", myList[j])

