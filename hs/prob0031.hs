possibilities = [ (a,b,c,d,e,f,g,h) |
					a <- [1],
					b <- [0..100],
					c <- [0..40],
					d <- [0..20],
					e <- [0..10],
					f <- [0..4],
					g <- [0..2],
					h <- [0..1] ]

laundry :: (Int,Int,Int,Int,Int,Int,Int,Int) -> Bool
laundry (a,b,c,d,e,f,g,h) = rec 7 0
	where
		rec :: Int -> Int -> Bool
		rec 0 acc	= if acc <= 200
						then True
						else False
		rec 1 acc	= if (acc + (b*2)) <= 200
--						then rec 0 (acc + (b*2))
						then True
						else False
		rec 2 acc	= if (acc + (c*5)) <= 200
						then rec 1 (acc + (c*5))
						else False
		rec 3 acc	= if (acc + (d*10)) <= 200
						then rec 2 (acc + (d*10))
						else False
		rec 4 acc	= if (acc + (e*20)) <= 200
						then rec 3 (acc + (e*20))
						else False
		rec 5 acc	= if (acc + (f*50)) <= 200
						then rec 4 (acc + (f*50))
						else False
		rec 6 acc	= if (acc + (g*100)) <= 200
						then rec 5 (acc + (g*100))
						else False
		rec 7 acc	= if (acc + (h*200)) <= 200
						then rec 6 (acc + (h*200))
						else False

main = putStrLn ("Result: " ++ (show(length(filter laundry possibilities))))
