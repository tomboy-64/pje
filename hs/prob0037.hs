import Math.NumberTheory.Primes.Testing
import Math.NumberTheory.Primes.Sieve
import Data.List
import Data.Char

findThemPrimes :: [Int]
findThemPrimes = filter checkIt (map fromInteger (dropWhile (<10) primes))
	where
		checkIt :: Int -> Bool
		checkIt x = check (show x) && check2 (show x)
		check :: String -> Bool
		check []			= True
		check testee		= if isPrime (read testee)
								then check (tail testee)
								else False
		check2 []			= True
		check2 testee		= if isPrime (read testee)
								then check2 (init testee)
								else False

main = mapM_ (putStrLn . show) ((take 11 findThemPrimes) ++ [(sum $ take 11 findThemPrimes)])
