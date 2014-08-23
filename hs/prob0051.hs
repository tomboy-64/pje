import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List
import Debug.Trace

createReplacementPatterns :: Integer -> [[Integer]]
createReplacementPatterns number =
--								filter (\x -> length x < length (show number)) $
								filter (/= [])
								$ subsequences
								$ take (length (show number)) [0..]

replaceDigits :: Integer -> [Integer] -> [[Char]]
replaceDigits number pattern 	= filter (isPrime . fromIntegral . read)
									$ filter (\x -> not $ head x == '0')
									$ map (\x -> rD (show number) pattern x) ['0'..'9']
	where
		rD :: [Char] -> [Integer] -> Char -> [Char]
		rD as [] _	= as
		rD as (b:bs) c = rD ((take (fromIntegral b) as) ++ [c] ++ (drop ((fromIntegral b)+1) as)) bs c

createFamilies :: Integer -> [[String]]
createFamilies origin = map (replaceDigits origin) (createReplacementPatterns origin)

resultValue value = maximum $ map length (createFamilies value)

solLit = zip (sieveFrom 10) (map resultValue (sieveFrom 10))

main = mapM_ (putStrLn . show) (takeWhile (\(_,x) -> x<8) solLit ++ (take 1 $ dropWhile (\(_,x) -> x<8) solLit)) 
--			(putStrLn . show) (take 1 $ dropWhile (\(_,x) -> x<8) solLit)
