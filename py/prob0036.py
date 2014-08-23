#!/usr/bin/env python

import sys
import math

def is_palindrome(x):
	result = True
	for i in range(len(x)//2):
		if(x[i] != x[len(x) - 1 - i]):
			result = False
			break
	return result

result = 0
for i in range(1, 1000000, 2):
	if( is_palindrome(str(i)) and is_palindrome(bin(i)[2:]) ):
		result += i
		print(i, "<=>", bin(i))

print("\nResult:", result)
