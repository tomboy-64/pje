import Data.Char
import Data.List

fC :: Int -> Bool
fC x = fC' (reverse(sort(show x))) 0
	where
		fC' :: String -> Int -> Bool
		fC' [] acc		= if acc == x
							then True
							else False
		fC' (a:as) acc	= if (acc + (fac(digitToInt a))) <= x
							then fC' as (acc + (fac(digitToInt a)))
							else False

fac x = fac' x 1
	where
		fac' 0 acc = acc
		fac' y acc = fac' (y-1) (acc * y)

final = filter fC [3..]

main = mapM_ (putStrLn . show) (scanl1 (+) final)
