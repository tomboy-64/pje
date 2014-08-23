import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List

allNumbers = filter (/= "") $ concat $ map permutations ["123456789", "12345678", "1234567", "123456", "12345", "1234", "123", "12", "1"]

candidates = reverse (sort (map (\x -> (read x)::Int) allNumbers))

isPdPrime :: Integer -> Bool
isPdPrime x = isPdP (sort(show x))
	where
		isPdP []		= True
		isPdP (_:[])	= True
		isPdP (a:b:cs)	= if a == b || a == '0' || b == '0'
							then False
							else isPdP (b:cs)

--main = mapM_ (putStrLn . show) $ filter isPdPrime (takeWhile (<= 10000000000) (primes))
main = mapM_ (putStrLn . show) $ take 10 $ filter (\x -> isPrime (fromIntegral x)) candidates
