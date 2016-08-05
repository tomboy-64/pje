import Math.NumberTheory.Primes.Testing
import Math.NumberTheory.Primes.Factorisation
import Data.List

my_abs = [ 2 .. 100 ]
my_ff = sort $ concat $ map (\x -> map (\y -> x ^ y) my_abs) my_abs

reductor :: [Integer] -> [Integer]
reductor (a:b:[]) = (dedouble a b) ++ [b]
reductor (a:b:xs) = (dedouble a b) ++ (reductor (b:xs))

dedouble :: Integer -> Integer -> [Integer]
dedouble a b
	| a == b = []
	| otherwise = [a]

main = do
	mapM_ (putStrLn . show) $ reductor my_ff
	putStrLn . show $ length $ reductor my_ff
