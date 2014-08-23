import sys

def one():
	return 3
def two():
	return 3
def three():
	return 5
def four():
	return 4
def five():
	return 4
def six():
	return 3
def seven():
	return 5
def eight():
	return 5
def nine():
	return 4
def ten():
	return 3
def eleven():
	return 6
def twelve():
	return 6
def twen():
	return 4
def thir():
	return 4
def far():
	return 3
def fif():
	return 3
def eigh():
	return 4
def twen():
	return 4
def hundred():
	return 7
def thousand():
	return 8
def ty():
	return 2
def teen():
	return 4
def annd():
	return 3

dozen = [ 0, one(), two(), three(), four(), five(), six(), seven(), eight(), nine(), ten(), eleven(), twelve() ]
teens =   [ 0, 0, 0, thir(), four(), fif(), six(), seven(), eigh(), nine() , 0 ]
cent = [ 0, 0, twen(), thir(), far(), fif(), six(), seven(), eigh(), nine() , 0 ]

print()
summ = 0
for i in range(1,1001):
	sys.stdout.write(str(i) + " : ")
	if i == 1000:
		summ += one() + thousand()
	else:
		if i >= 100:
			summ += dozen[i // 100]
			summ += hundred()
			if i % 100 != 0:
				summ += annd()
#			print(dozen[i//100], i, hundred())

		i = i - (i//100) * 100
		if i <= 12:
			summ += dozen[i]
		elif i <= 19:
			summ += teens[i-10] + teen()
		else:
			summ += (cent[i//10] + ty())
			summ += dozen[i%10]
	print(":", summ)
print(summ)
