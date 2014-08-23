n=5

check :: Int -> Int -> String
check x y = if (x - 2^(n-1))^2 + (y - 2^(n-1))^2 <= 2^(2*n-2)
				then "0"
				else "1"

matrix :: [[(Int,Int)]]
matrix = [[ (x,y) | x <- [0..(2^n-1)] ] | y <- [0..(2^n-1)] ]

longString = concat (map
				(\line -> (concat (map
							(\(a,b) -> (check a b)++" ")
							line)) ++ "\n")
				matrix)

main = (putStrLn) ("P1\n" ++ (show (2^n)) ++ " " ++ (show (2^n)) ++ "\n" ++ longString)
