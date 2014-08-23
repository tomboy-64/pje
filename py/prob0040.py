#!/usr/bin/dev python

loopee = 1
index = 0
result = 1
iteration = 0
while iteration < 6:
	lole = len(str(loopee))
	index += lole
	if index >= 10**iteration:
		nextOne = int(str(loopee)[10**iteration-index-1])
		iteration += 1

		result *= int(nextOne)
		print(iteration, ":", nextOne, "=>", result)
	loopee += 1
