result = 0
for a in range(100, 1000):
	for b in range(a, 1000):
		nlist = []
		number = a*b
		c = number
		while c > 0:
			nlist += [ c % 10 ]
			c -= c % 10
			c /= 10
		top = len(nlist) - 1
		bot = 0
		while (top - bot >= 1):
			if nlist[bot] == nlist[top]:
				if ((top - bot) <= 1):
					if (result < number):
						result = number
						print(number, " - ", a, "x", b)
					bot, top = 0, 0
				else:
					bot += 1
					top -= 1
			else:
				bot, top = 0, 0

print( "\n === \n", result)
