n = [ 2 ]
counter = 3
while (len(n) <= 10000):
				test = True
				for i in n:
								if (test and (counter % i == 0)):
												test = False
				if test:
								n += [ counter ]
								print(len(n), ":", counter)
				counter += 1

