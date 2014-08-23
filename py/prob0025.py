#!/usr/bin/env python

pre = 1
number = 1
ctr = 2
while len(str(number)) < 1000:
	new = number + pre
	pre = number
	number = new
	ctr += 1

print(ctr, ":", number)
