import Data.Char
import Data.List
import Data.Maybe
import Debug.Trace

fact :: (Eq x, Num x) => x -> x
fact 0 = 1
fact a = a * fact (a - 1)

f :: Int -> Int
f n = sum (map f' (show n))
	where
		f' :: Char -> Int
		f' x = fact (digitToInt x)

f_list = map f [0..]

sf :: Int -> Int
sf n = sf' (show (f_list !! n))
	where
		sf' [] = 0
		sf' (b:bs) = (digitToInt b) + (sf' bs)

sf_list = map sf [0..]

g :: Int -> Int
--g i = head $ filter (\x -> sf x == i) [1..]
g i = trace (show i) fromJust $ elemIndex i sf_list

g_list = 0:(map g [1..])

sg :: Int -> Int
{-sg i = sg' (show (g i))
	where
		sg' [] = 0
		sg' (b:bs) = (digitToInt b) + (sg' bs)
-}
sg i = sg' (show (g_list !! i))
	where
		sg' [] = 0
		sg' (b:bs) = (digitToInt b) + (sg' bs)

main = do
		(putStrLn . show) (sum $ map sg [1..20])
		(putStrLn . show) (sum $ map sg [1..30])
		(putStrLn . show) (sum $ map sg [1..40])
		(putStrLn . show) (sum $ map sg [1..50])
		(putStrLn . show) (sum $ map sg [1..60])
		(putStrLn . show) (sum $ map sg [1..70])
		(putStrLn . show) (sum $ map sg [1..80])
		(putStrLn . show) (sum $ map sg [1..90])
		(putStrLn . show) (sum $ map sg [1..100])
		(putStrLn . show) (sum $ map sg [1..150])
