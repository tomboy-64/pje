e (x,y) | y == 0 		= 0
	| x == y || y == 1	= 1
	| x == 1		= 2
	| otherwise		= (e (y,(x `rem` y))) +1
{-	where e' a b
		| a <= b 		= (!!) ((!!) e_field (b-1)) (a-1)
		| a > b  		= (!!) ((!!)e_field (a-1)) (a+b-1)-}

e_row n = map e (concat [zip [1..n] (repeat n),(zip (repeat n) [1..(n-1)])])
e_field = map e_row [1..]

--period_fix_x n = map (\y -> e(n,y)) [(n+1)..(2*n)]	-- the period is offset by n
period_fix_y n = map (\x -> e(x,n)) (rotl 1 [0..(n-1)]) -- the period starts at 0, but has to be rotated by 1
-- period_fix_x = period_fix_y + 1
period_fix_x n = map (1 +) (period_fix_y n)
period_fix_x_init n = map (\z -> if (z==1) then 1 else if (z>1) then (z-1) else (-1)) (period_fix_y n)

f_row_sum row maxN = (sum (period_fix_y row) + 
			(sum (period_fix_x_init row))) -1

rotl :: Int -> [Int] -> [Int]
rotl n xs = concat [(drop n xs),(take n xs)]

s n = sum $ map sum (take n e_field)

main = 
{-	putStrLn ("1:       " ++ show (s 1))
	putStrLn ("10:      " ++ show (s 10))
	putStrLn ("100:     " ++ show (s 100))
	putStrLn ("1000:    " ++ show (s 1000))
	putStrLn ("10000:   " ++ show (s 10000))
	putStrLn ("100000:  " ++ show (s 100000))
	putStrLn ("1000000: " ++ show (s 1000000))
	putStrLn ("5000000: " ++ show (s 5000000))-}
	
	mapM_
		(\z -> putStrLn (
			show z ++ ":\n"
			++ show (map (\y -> e(z,y)) [1..z]) ++ "\n"
			++ show (period_fix_x_init z) ++ "\n"
			++ show (period_fix_x z) ++ "\n"
			++ show (period_fix_y z) ++ "\n"
			++ show (e_row z) ++ "\n"
		))
		[1..30]
