import Data.List
import Data.List.Split
import Math.NumberTheory.Powers
import Debug.Trace

dropTill :: (a -> Bool) -> [a] -> [a]
dropTill t xs = drop 1 (dropWhile t xs)
takeTill :: (a -> Bool) -> [a] -> [a]
takeTill t xs = takeWhile t xs ++ (take 1 (dropWhile t xs))


endlSqrt :: Int -> [Int]
endlSqrt n = rec 0 0 start
	where
		--start = read ((firstIter n) !! 0)
		start = map read (firstIter n)

		firstIter :: Int -> [String]
		firstIter n =
			if even(length (show n))
				then (chunksOf 2 (show n)) ++ ["-1"]
				else (chunksOf 2 ('0':(show n))) ++ ["-1"]

		rec :: Integer -> Integer -> [Integer] -> [Int]
		rec p remainder (rest)
			| p == 0			= [fromIntegral (integerSquareRoot (head rest))]
									++ rec
										(integerSquareRoot (head rest))
										((head rest)-(integerSquareRoot (head rest)))
										(drop 1 rest)
			| rest == [(-1)]	= [10] ++ rec p remainder (drop 1 rest)
			| otherwise			= [fromIntegral x] ++ rec (p*10+x) (c-((p*20+x)*x)) (drop 1 rest)

			where
				c	| rest == []		= remainder *100
					| otherwise			= remainder *100 + (head rest)
				x	= --trace ("\n" ++ (show remainder) ++ " " ++ (show p) ++ (show rest))
						maximum
						$ filter (\x -> x*(20*p+x) <= c) [0..9]

searchspace = [ (a,b) | a <- [1..2011], b <- [a..2011], a+b <= 2011 ]
