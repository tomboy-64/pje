import Math.NumberTheory.Primes.Factorisation
import Data.Set
import Data.Maybe
import Math.NumberTheory.Powers
import Math.NumberTheory.Primes.Sieve
import Data.List
import Debug.Trace

--psr n = fromJust $ lookupLE (integerSquareRoot n) (divisors n)
psr n limit = psr' (subsequences (takeWhile (<190) primes)) [] 0 1
	where
		psr' []			[]		maxi	_ = maxi
		psr' (r:rest)	[]		maxi 	acc	= if acc > maxi && acc <= limit
												then
													trace (show acc)
													psr' rest r acc 1
												else psr' rest r maxi 1
		psr' (r:rest)	this	maxi	acc = if acc > maxi || acc > limit
												then psr' rest r maxi 1
												else psr' (r:rest) (drop 1 this) maxi (acc * (head this))



p = product $ takeWhile (<190) primes

main = putStrLn $ show $ (psr p (integerSquareRoot p)) `rem` (10^16)
