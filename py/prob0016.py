#!/usr/bin/env python

number = str(pow(2,1000))
summ = 0
for i in range(len(number)):
	summ += int(number[i])

print(summ)
