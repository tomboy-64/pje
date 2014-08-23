import Data.Char

fact 0 = 1
fact n = n*fact(n-1)

nextLink n = sum (map (\x -> fact(digitToInt x)) (show n))

nonRep y = nRrec y []
	where
		nRrec y acc = if y `elem` acc || length acc >= 61
						then acc
						else nRrec (nextLink y) (y:acc)

result = length $ filter (\x -> length x == 60) $ map nonRep [1..999999]

main = putStrLn ("Result: " ++ (show result))
