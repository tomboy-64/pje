#!/usr/bin/env python

import io
import sys

f = open("matrix.txt", "r")
text = f.readlines()
f.close()

matrix = []
for i in text:
	matrix += [[]]
	for j in i.rstrip('\n').split(","):
		matrix[len(matrix)-1] += [ int(j) ]

# transform into 2
mat1, mat2 = [], []
for i in range(80):
	mat1 += [[]]
	mat2 += [[]]
	for j in range(i+1):
		mat1[i] += [ matrix[i-j][j] ]
		mat2[i] += [ matrix[79-j][79-i+j] ]

sane = True
minPathMat1 = []
minPathMat2 = []
for i in range(80):
	if mat1[79][i] != mat2[79][i]:
		sane = False
	minPathMat1 += [[ i, [mat1[79][i]] ]]
	minPathMat2 += [[ i, [mat2[79][i]] ]]

sys.stdout.write("Sanity test")
if not sane:
	sys.stdout.write(" not")
sys.stdout.write(" passed.\n\n")

for i in range(1, 80):
	for j in range(80):
		if( minPathMat1[j][0] == 0 ):
			pass
		elif( minPathMat1[j][0] == (79-i+1) ):
			minPathMat1[j][0] = 79-i
		elif( mat1[79-i][minPathMat1[j][0]-1] < mat1[79-i][minPathMat1[j][0]] ):
			minPathMat1[j][0] -= 1
		minPathMat1[j][1] = [ mat1[79-i][minPathMat1[j][0]] ] + minPathMat1[j][1]
	
		if( minPathMat2[j][0] == 0 ):
			pass
		elif( minPathMat2[j][0] == (79-i+1) ):
			minPathMat2[j][0] = 79-i
		elif( mat2[79-i][minPathMat2[j][0]-1] < mat2[79-i][minPathMat2[j][0]] ):
			minPathMat2[j][0] -= 1
		minPathMat2[j][1] += [ mat2[79-i][minPathMat2[j][0]] ]

mini = [10000000, []]
for i in range(80):
	minPathMat1[i][1][79:] = []
	minPathMat1[i][1] += minPathMat2[i][1]
	minPathMat1[i][0] = sum(minPathMat1[i][1])
	if mini[0] > minPathMat1[i][0]:
		mini = [minPathMat1[i][0], minPathMat1[i][1]]

i, j = 0,0
for k in range(159):
	sys.stdout.write(str(k) + " " + str(i) + " " + str(j) + ": " + str(mini[1][k]))
	if k < 158:
		if j < 79 and matrix[i][j+1] == mini[1][k+1]:
			sys.stdout.write(" right\n")
			j += 1
		elif i < 79 and matrix[i+1][j] == mini[1][k+1]:
			sys.stdout.write(" down\n")
			i += 1
		else:
			print("FAIL")
			exit()

print("\n", mini[0])
summ=0
for i in matrix:
	print(i)
