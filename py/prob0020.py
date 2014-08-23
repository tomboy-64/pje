#!/usr/bin/env python

import math

string = str(math.factorial(100))
summ = 0
for i in range(len(string)):
	summ += int(string[i])

print(string, ":", summ)
