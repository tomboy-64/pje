#!/usr/bin/env python
import itertools as i

def decLet(a):
	return "ABCDEFGHIJ".index(a)

def let2Int(a):
	acc = 0
	for i in range(length(a)):
		acc += decLet(a[i]) * 10^(length(a)-1-i)

def extractHSum(a)
	return a[a.index('h')]

def parseData(line):
	dim = 0
	sumhTest = 0
	currentSum = 'x'
	hMatrix = list()
	vMatrix = list()
# here we convert the string into our matrix
	for i in range(length(line))
# determine dimension of the puzzle
		if i == 0
			dim = line[i]
# transformation for vMatrix
		if line[i] == '('
			sumhTest = 1
		elif line[i] == ')'
			sumhTest = 0
		elif sumTest == 0
			if line[i] == 'O'
				hMatrix[length(hMatrix)-1][i+10] += 1
			if line[i] in "ABCDEFGHIJ"
				hMatrix[length(hMatrix)-1][decLet(line[i])] += 1
		elif sumTest == 1
			if line[i] == 'h'
				hMatrix.append(list(i.repeat(0,60)))
				currentSum = 'h'
			if currentSum == 'h'
				if line[i] in "ABCDEFGHIJ"
					if line[i+1] in "ABCDEFGHIJ"
						hMatrix[length(hMatrix)-1][decLet(line[i])] -= 10
					else
						hMatrix[length(hMatrix)-1][decLet(line[i])] -= 1
						currentSum = 'x'
# vertical matrix
	   0 7 14 21 28
				1 8 15	22	29
				(x%7 * 7) + (x//7)
				n*7
				n*7+


	
# loop over the line to get the horizontal sequences


f = open('kakuro200.txt', 'r')

for line in f:
	parseData(line.rstrip('\n'))

f.close()

