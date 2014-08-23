import Data.Function (fix)
import Math.NumberTheory.Primes (primes)

hamm = 1:foldl (\s n->fix (merge s.(n:).map (n*))) [] ( reverse (takeWhile (<=100) primes))

merge [] b = b
merge a [] = a
merge a@(x:xs) b@(y:ys)
		| x < y     = x:merge xs b
		| otherwise = y:merge a ys

main = (putStrLn . show) $ length $ takeWhile (<=10^9) hamm
