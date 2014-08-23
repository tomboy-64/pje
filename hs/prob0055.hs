import Data.List

isLychrel x = iL (show x) 0
	where
		iL a b	= if b > 50
				then 1
				else if isPal newCons
					then 0
					else iL newCons (b+1)
			where
				newCons :: String
				newCons = show(((read a) :: Integer) + ((read (reverse a)) :: Integer))
				isPal :: String -> Bool
				isPal x = if length x <= 1
							then True
							else if head x == last x
								then isPal (init(tail x))
								else False

main = putStrLn $ show $ sum $ map isLychrel [1..9999]
