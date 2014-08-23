#!/usr/bin/env python

a, b, c = 1, 2, 3

def pythagorean (a, b, c):
	if ( a**2 + b**2 == c**2 ):
		print("a:", a, "b:", b, "c:", c)
		if (a + b + c == 1000):
			print("JACKPOT:", a*b*c)
			return False
		else:
			return True
	else:
		return True

while pythagorean(a,b,c):
	if (a + 1 < b):
		a += 1
	else:
		a = 1
		if (b + 1 < c):
			b += 1
		else:
			b = 2
			c += 1
