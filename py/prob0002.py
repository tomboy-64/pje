#!/usr/bin/env python

a, b, c, result = 0, 1, 2, 0
while (c <= 4000000):
	if (c % 2 == 0):
		result += c
		print( result )
	a = b
	b = c
	c += a
