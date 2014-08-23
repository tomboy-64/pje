possibilities = [ (a,b,c,d) |
					a <- [0..50],
					b <- [0..50],
					c <- [0..50],
					d <- [0..50],
					a /= 0 || b /= 0,
					c /= 0 || d /= 0,
					a /= c || b /= d ]

result = filter myFilter possibilities
	where
		myFilter (a,b,c,d) = if or [ x `scalar` y == 0,
									x `scalar` z == 0,
									y `scalar` z == 0 ]
					then True
					else False
			where
				x = (a,b)
				y = (c,d)
				z = (a-c, b-d)
				scalar (p,q) (r,s) = p*r + q*s

main = (putStrLn . show) ((length result) `div` 2)
