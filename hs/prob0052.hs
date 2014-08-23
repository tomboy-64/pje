import Data.List
orgNum = [1..]
numbers = map (sort . show) orgNum
numbers2 = map (\x -> sort (show (x*2))) orgNum
numbers3 = map (\x -> sort (show (x*3))) orgNum
numbers4 = map (\x -> sort (show (x*4))) orgNum
numbers5 = map (\x -> sort (show (x*5))) orgNum
numbers6 = map (\x -> sort (show (x*6))) orgNum

result (a:as) (b:bs) (c:cs) (d:ds) (e:es) (f:fs) (x:xs) = 
		if and [a == b, c == d, e == f, a == c, a == f]
			then x
			else result as bs cs ds es fs xs

main = (putStr . show) $ result numbers numbers2 numbers3 numbers4 numbers5 numbers6 orgNum
