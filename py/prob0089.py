#!/usr/bin/env python

import io
import sys

alias = { 'I' : 1, 'V' : 5, 'X' : 10, 'L' : 50, 'C' : 100, 'D' : 500, 'M' : 1000 }


def decode(x):
	result = 0
	prev = ""
	for i in x:
		if prev == "":
			prev = i
		elif alias[prev] >= alias[i]:
			result += alias[prev]
			prev = i
		elif alias[prev] < alias[i]:
			result -= alias[prev]
			prev = i
	result += alias[prev]
	sys.stdout.write(str(x) + " : " + str(result))
	return [result, len(x)]

def encode(x):
	result = ""
	if x >= 1000:
		for i in range(x//1000):
			result += "M"
			x -= 1000
	if x >= 900:
		result += "CM"
		x -= 900
	if x >= 500:
		result += "D"
		x -= 500
	if x >= 400:
		result += "CD"
		x -= 400
	if x >= 100:
		for i in range(x//100):
			result += "C"
			x -= 100
	if x >= 90:
		result += "XC"
		x -= 90
	if x >= 50:
		result += "L"
		x -= 50
	if x >= 40:
		result += "XL"
		x -= 40
	if x >= 10:
		for i in range(x//10):
			result += "X"
			x -= 10
	if x == 9:
		result += "IX"
		x -= 9
	if x >= 5:
		result += "V"
		x -= 5
	if x == 4:
		result += "IV"
		x -= 4
	if x >= 1:
		for i in range(x):
			result += "I"
			x -= 1
	if x != 0:
		print("\n", result, "\nERROR")
		exit()
	
	sys.stdout.write(" : " + str(result) + "\n")
	return len(result)

f = open("roman.txt", "r")
text = f.readlines()
f.close()

for i in range(len(text)-1):
	text[i] = text[i].rstrip('\n')

sum_before = 0
sum_after = 0
tmp = [0,0] 
for i in text:
	tmp = decode(i)
	sum_before += tmp[1]
	sum_after += encode(tmp[0])

print("Result:", sum_before, ":", sum_after, ":", sum_before - sum_after)
