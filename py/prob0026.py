#!/usr/bin/env python

import itertools
import sys

class nums:
	number = 0
	mantissa = ""
	remainders = [ 10 ]

main_list = [nums() for x in range(999)]
for i in range(len(main_list)):
	main_list[i].number = 999-i-1
	main_list[i].remainders = [10]
maxi = 0
while True:
	for i in main_list:
		if i.number == 0:
			continue
		
		index = len(i.remainders)-1
		rem = i.remainders[index] % i.number
		quot = i.remainders[index] // i.number
		if quot == 0:
			i.remainders[ index ] *= 10
			i.mantissa += str(quot)
		elif rem == 0:
			i.number = 0
		else:
			i.mantissa += str(quot)
			i.remainders += [ rem * 10 ] 
			index += 1
		
		if i.remainders.count( i.remainders[index] ) > 1:
			result = i.remainders.index( i.remainders[index] )
			length = len(i.mantissa) - result -2
#			print('rem, quot, number', result, rem, quot, i.number, i.remainders[index], i.mantissa, index)
			if length > maxi:
				maxi = length
				print("New maxi with", i.number, "-", length, "long.")
			elif length == maxi:
				print("Same maxi with", i.number, "-", length, "long.")
			else:
				print("Minor:", i.number, length)

			for j in range( len(str(i.number)) ):
				sys.stdout.write(" ")
			sys.stdout.write("     ")
			for j in range( len(i.mantissa) ):
				if j <= result+1:
					sys.stdout.write( "." )
				else:
					sys.stdout.write( "_" )
			sys.stdout.write("\n")

			sys.stdout.write( str(i.number) + " | 0." )
			print(i.mantissa)
			sys.stdout.write("\n")
			if i.number == 8:
				exit()
			i.number = 0
