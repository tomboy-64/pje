a, total = 1, 0
while a < 1000:
	if a % 3 == 0:
		total = total + a
	elif a % 5 == 0:
		total = total + a
	a += 1

print(total)
