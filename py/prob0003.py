#!/usr/bin/env python

counter, result, bigNum = 2, 0, 600851475143
while (bigNum != 1):
	if (bigNum % counter == 0):
		result = counter
		bigNum /= counter
		print(result)
	else:
		counter += 1
