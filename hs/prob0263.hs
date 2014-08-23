import Math.NumberTheory.Primes.Sieve
import Debug.Trace

a005153 n = a005153_list !! (n-1)
a005153_list = filter f [1..]
	where
		f n = and $ map (p [d | d <- [1..n], mod n d == 0]) [1..n]
		p _  0 = True
		p [] _ = False
		p (d:ds) m
			| m < d     = False
			| otherwise = p ds (m - d) || p ds m 

firestarter = checkPracticals (takeWhile (<16) a005153_list)

checkPracticals :: [Int] -> Int -> [Int] -> [Int]
checkPracticals window	next	acc		= 
