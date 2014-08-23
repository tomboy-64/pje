import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Debug.Trace

checkSums n = sum $ map (\x -> cSrec [x]) (takeWhile (< n) primes)
	where
		cSrec acc = if (isPrime $ n - (sum acc)) && (n-(sum acc)) <= (head acc)
						then 1 + (sum
							$ map (\x -> cSrec (x:acc))
								(takeWhile (<= head acc) (takeWhile (<n-(sum acc)) primes)))
						else sum
							$ map (\x -> cSrec (x:acc))
								(takeWhile (<= head acc) (takeWhile (<n-(sum acc)) primes))

main = mapM_ (putStrLn.show) (takeWhile (\(_,x) -> x<=5000) (map (\x -> (x, checkSums x)) [1..]))

