#!/usr/bin/env python

a, b = 0, 0
for i in range(1, 101):
				a += i ** 2
				b += i
b = b ** 2
c = b - a

print( "a:", a, "\nb:", b, "\nc:", c )
