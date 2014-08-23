#!/usr/bin/env python

import sys

week = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" ]
year = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]

day = "Monday"
ctr = 0
for i in range(1900, 2001):
	sys.stdout.write(str(i) + ": ")
	for j in year:
		if day == "Sunday":
			if i>1900:
				ctr += 1
			sys.stdout.write("x")
		else:
			sys.stdout.write(".")
		sys.stdout.flush()

		days = 0
		if j in [ "Jan", "Mar", "May", "Jul", "Aug", "Oct", "Dec" ]:
			days = 31
		elif j in [ "Apr", "Jun", "Sep", "Nov" ]:
			days = 30
		elif j == "Feb":
			days = 28
			if (i % 4 == 0) and i != 1900:
				days += 1
		else:
			print("Ooops")
			exit()

#		print(day)
		day = week[ (week.index(day) + days) % 7 ]
	sys.stdout.write("\n")
	sys.stdout.flush()

print()
print(ctr)
