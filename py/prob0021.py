#!/usr/bin/env python

import math

def divisors(x):
	result = []
	if x==1:
		result = [1]
	else:
		for i in range(1, int(math.sqrt(x)+1)):
			if x%i == 0:
				temp = int(x/i)
				result += [ i ]
				if temp != i and i != 1:
					result += [ temp ]
	
	result.sort()
	return result

divsum, amicables = [0], []
for i in range(1, 10000):
# each entry i in divisorsum is the sum of (i-1)'s divisor
	divisor = divisors(i)
	divsum += [ sum(divisor) ]
#	print(i, ":", divsum[i], ":", divisor)
	if (len(divsum) > divsum[i] and divsum[i] != i):
		if divsum[divsum[i]] == i:
			amicables += [ i, divsum[i] ]
			print(amicables[len(amicables)-2:])
	
print(amicables)
print(sum(amicables))
	
	
