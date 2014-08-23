import Math.NumberTheory.Primes.Factorisation

import Math.NumberTheory.Powers.Squares


main = ( putStrLn . show ) $ sum $ filter (\x -> isSquare (σ 2 x)) [1..64000000]
