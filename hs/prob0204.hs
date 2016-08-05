import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Powers.Squares
import Data.Array
import Debug.Trace

maxi :: Int 
maxi = 10^8
main = (putStrLn . show)
		$ rec
			(listArray (1,maxi) (take maxi (repeat 1)))
			(takeWhile (\x -> x<=maxi) (map fromIntegral (sieveFrom 7)))

rec myArr [] = sum $ map (\x -> myArr ! x) [1..maxi]
rec myArr (r:rest) =
	rec
		(myArr//(takeWhile (\(i,_) -> i<=maxi) [ (i,0) | i<-[r, r*2..]]))
		rest

--main = (putStrLn . show) $length (filter myFilter [2..10^8])
