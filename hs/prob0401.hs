divisors n = dvs !! (n-1)

indices = map (\x -> floor $ sqrt x) [0..]

lstOfSq = map (\x -> x^2) [0..]

leftHalf n 
	| n < 1		-> error ((show n) ++ " not available.")
	| n == 1	-> 1
	| otherwise	-> 
