import Data.Ratio

candidates = [ (a,b) |  a <- [10..99]
					, b <- [10..99]
					, test a b ]

test :: Int -> Int -> Bool
test a b = t' (show a) (show b)
	where
		t' :: [Char] -> [Char] -> Bool
		t' x y = and [
					a < b,
					x!!0 /= '0',
					x!!1 /= '0',
					y!!0 /= '0',
					y!!1 /= '0',
					x /= y,
					or [ x!!0 == y!!0 && a%b == (read [x!!1]) % (read [y!!1]),
						x!!1 == y!!0 && a%b == (read [x!!0]) % (read [y!!1]),
						x!!0 == y!!1 && a%b == (read [x!!1]) % (read [y!!0]),
						x!!1 == y!!1 && a%b == (read [x!!0]) % (read [y!!0]) ]
					]

result :: [(Int,Int)] -> (Int,Int)
result ((a,b):(c,d):[]) = (a*c,b*d)
result (x:xs) = result (x:[result xs])

main = do
	mapM_ (putStrLn . show) candidates
	(putStrLn . show) $ result candidates
