#!/usr/bin/env python

import io
import sys

f = open("keylog.txt", "r")
text = f.readlines()
f.close()

newtext = []
new2text = []
for i in text:
	newtext += [ i[0:2], i[1:3], i[0]+i[2] ]
	

for i in newtext:
	if not i in new2text:
		new2text += [ i ]

print("split into pairs, removed duplicates:\n", new2text, "\n")

print("Conditions:")
conditions = []
for i in range(10):
	tmp1, tmp2 = [], []
	for j in new2text:
		if int(j[0]) == i:
			if not int(j[1]) in tmp2:
				tmp2 += [ int(j[1]) ]
		if int(j[1]) == i:
			if not int(j[0]) in tmp1:
				tmp1 += [ int(j[0]) ]
	tmp1.sort()
	tmp2.sort()
	conditions += [[ tmp1, tmp2 ]]
	print(tmp1, "<", i, "<", tmp2)

print()
for i in conditions:
	print(i)

