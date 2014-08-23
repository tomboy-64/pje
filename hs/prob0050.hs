import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List
import Debug.Trace

limit = 1000000

nextList remPrimes = nL [head remPrimes] (tail remPrimes)
	where
		nL :: [Int] -> [Int] -> [Int]
		nL as [] = as
		nL as (b:bs) = if (sum as) + b > limit
			then as
			else nL (b:as) bs


recursor :: [Int] -> Int -> Maybe [Int]
recursor [] _ = Nothing
recursor rest@(_:as) max = if length rest <= max
							then Nothing
							else if isPrime $ fromIntegral (sum rest)
								then Just rest
								else recursor as max

checkador :: [Int] -> (Int, Int) -> (Int, Int)
checkador [] acc = acc
checkador thePrimes acc = case recursor (nextList thePrimes) (fst acc) of
	Nothing -> checkador (tail thePrimes) acc
	Just x -> checkador (tail thePrimes) (length x, sum x)

main = (putStrLn . show) (checkador (takeWhile (<limit) (map fromIntegral primes)) (0,0))
