import gmpy2

LINE_NO = [ 8, 10000 ]

for i in LINE_NO:
	searchprimes = []
	targets = []
	for j in range(i-2, i+3):
		searchprimes += [[]]
		for k in range(sum(range(j)) + 1, sum(range(j)) + 1 + j):
			searchprimes[len(searchprimes)-1] += [ k ]


	print()

	for k in [0,1,3,4]:
		for l in range(len(searchprimes[k])-1):
			if gmpy2.is_prime(searchprimes[k][l]):
				searchprimes[k][l] = str(searchprimes[k][l])
		
	print( str(i) + ":")
	for i in searchprimes:
		print(i)

#	for j in range(len(searchprimes[2])):
#		if gmpy2.is_prime(searchprimes[2][j]):
#			for k in searchprimes:
#				print(k[j:j+1])
