import Data.List
import Data.Maybe
import Debug.Trace

triangle	= limit $ map (\ n -> (n*(n+1)) `div` 2)	[1..]
triangle'	= map (\x -> [x]) triangle
square		= limit $ map (\ n -> n^2)					[1..]
pentagonal	= limit $ map (\ n -> (n*(3*n-1)) `div` 2)	[1..]
hexagonal	= limit $ map (\ n -> n*(2*n-1))			[1..]
heptagonal	= limit $ map (\ n -> (n*(5*n-3)) `div` 2)	[1..]
octagonal	= limit $ map (\ n -> n*(3*n-2))			[1..]

limit :: [Int] -> [Int]
limit x = dropWhile (<999) (takeWhile (<10000) x)

allIsWell :: [[[Int]]]
allIsWell = permutations $ [ square, pentagonal, hexagonal, heptagonal, octagonal ]

cyclic :: [[Int]] -> [Int] -> [[Int]]
cyclic as bs = concat $ map stage1 as
	where
		stage1 :: [Int] -> [[Int]]
		stage1 a = catMaybes $ map stage2 bs
			where
				stage2 :: Int -> Maybe [Int]
				stage2 b = if drop 2 (show $ head a) == take 2 (show b)
					then --trace ((show a) ++ " " ++ (show b))
						Just (b:a)
					else Nothing

--result :: [[[Int]]]
result = map (\ series -> map sum $ map reverse $ filter myFilter $ foldl cyclic triangle' (series )) allIsWell
main = mapM_ (putStrLn . show) $ result 

myFilter :: [Int] -> Bool
myFilter a = drop 2 (show (head a)) == take 2 (show (last a))
--	where
--		x = drop 2 (show $ head a)
--		y = take 2 (show $ last a)

