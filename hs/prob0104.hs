import Data.List
import Data.Bits
import Debug.Trace
 
fib :: Int -> Integer
fib n = snd . foldl' fib' (1, 0) . dropWhile not $
		[testBit n k | k <- let s = bitSize n in [s-1,s-2..0]]
			where
				fib' (f, g) p
						| p         = (f*(f+2*g), ss)
						| otherwise = (ss, g*(2*f-g))
							where ss = f*f+g*g

fibLst = [0] ++ (map fib [1..])

main = putStrLn ("Solution: " ++ (show (take 1 (dropWhile (\ n -> or [test1 n, test2 n]) [1..]))))

test1 :: Int -> Bool
test1 x = if test (take 9 (show (fib x)))
	then --trace ("first: " ++ (show x))
		False
	else True
test2 :: Int -> Bool
test2 x = if test ((\y -> drop ((length (show y))-10) (show y)) (fib x))
	then --trace ("last: " ++ (show x))
		False
	else True

test :: [Char] -> Bool
test x = test' x "123456789"
	where
		test' _ []				= True
		test' (ys) (z:zs)		= if z `elem` ys
									then test' ys zs
									else False
