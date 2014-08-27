-- Created by tomboy64 on 26-8-14
-- Solving Project Euler Problem #75
-- Stole some code (pythTripels) from wikipedia.de.



import Math.NumberTheory.Powers
import Data.List

pythTripels n = [(k*x, k*y, k*z) | (x,y,z) <- primitives, k <- [1..n`div`z]]
	where
		primitives = [(p^2-q^2, 2*p*q, p^2+q^2) | p <- takeWhile (\p -> p^2+1 <= n) [1..], q <- takeWhile (\q -> p^2+q^2 <= n) [1..p], odd (p+q) && gcd p q == 1]

allTripels = sortBy tripelSort
				$ filter (\(a,b,c) -> a+b+c < 1500000)
				$ pythTripels 750000
					where
						tripelSort (a,b,c) (d,e,f)
							| g > h = GT
							| g < h = LT
							| g == h = EQ
								where
									g = a+b+c
									h = d+e+f

counter :: Int -> [(Int,Int,Int)] -> Int
counter w [] = w
counter w (_:[]) = w + 1
counter w (y:zs)
	| added y == added (head zs)	= counter w (dropWhile (\n -> added n == added y) zs)
	| otherwise						= counter (w+1) zs
		where
			added (a,b,c) = a+b+c

main = putStrLn $ show $ counter 0 allTripels
