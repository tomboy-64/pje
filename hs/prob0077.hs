import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Debug.Trace

checkSums n = sum $ map (\x -> cSrec [x]) (takeWhile (< n) primes)
	where
		cSrec acc
			| (isPrime $ n - (sum acc))
				&& (n-(sum acc)) <= (head acc)	= 1 + summed
			| otherwise							= summed
				where
					summed = sum $ map (\x -> cSrec (x:acc))
									(takeWhile (<= head acc) (takeWhile (<n-(sum acc)) primes))

main = mapM_ (putStrLn.show) (takeWhile (\(_,x) -> x<=5000) (map (\x -> (x, checkSums x)) [1..]))

