import Math.NumberTheory.Powers
import Math.NumberTheory.Primes.Sieve
import Data.Set

maxi = 50000000

main = (putStrLn . show) $ size $ fromList [ a^2 + b^3 + c^4 |
								a <- takeWhile (<=integerSquareRoot maxi) primes,
								b <- takeWhile (<=integerCubeRoot   maxi) primes,
								c <- takeWhile (<=integerFourthRoot maxi) primes,
								a^2 + b^3 + c^4 <= maxi ]
