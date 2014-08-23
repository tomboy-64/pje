checkPivot :: Int -> Bool
checkPivot n = cP 1 (n+1)
	where
		cP range starter =
			if left == right
				then True
			else if left > right
				then cP range (starter + 1)
			else if starter == n+1
				then False
			else cP' (range + 1) (starter)
				where
					left = sqSA [(n - range) .. n]
					right = sqSA [starter .. (starter + range - 1)]
		cP' range starter =
			if left == right
				then True
			else if left > right
				then if starter == n+1
					then False
					else cP' (range + 1) (starter + 1)
			else cP' range (starter -1)
				where
					left = sqSA [(n - range) .. n]
					right = sqSA [starter .. (starter + range - 1)]


sqSA :: [Int] -> Int
sqSA [] = 0
sqSA (x:xs) = (x^2) + sqSA xs

myList = filter checkPivot [1..10^10]
