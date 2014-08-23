import multiprocessing
import sys

lookup = dict()

def f(x):
	if x == 0:
		return (1,0)
	elif x % 2 == 0:
		if x > 100000:
			print(x)
		return (sum(f(x//2)), f(x//2)[1])
	elif x % 2 == 1:
		if x > 100000:
			print(x)
		return (f(x//2)[0], sum(f(x//2)))

	
print(f(10**25))
