sqLst = map (\x -> x^2) [0..(10^7)]
modMat = map
			(\x -> map
				(\y -> y `mod` x)
				(reverse (take x sqLst))
			)
			[0..]

m n 
	| n == 1	= [1]
	| n == 2	= [2]
	| n	> 2		= zipWith (-) [(n-1), (n-2)..1]
