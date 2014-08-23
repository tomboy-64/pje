import Data.List

ring = [ [(xa, a, b),(xb, b, c),(xc, c, d),(xd, d, e),(xe, e, a)] |
			xa <- [10,9..1], xb <- [10,9..1], xc <- [10,9..1], xd <- [10,9..1], xe <- [10,9..1], 
			a <- [1..9], b <- [1..9], c <- [1..9], d <- [1..9], e <- [1..9], 
			xa+a == xb+c,
			xb+b == xc+d,
			xc+c == xd+e,
			xd+d == xe+a,
			xe+e == xa+b,
			and $ map (\x -> x > ((xa*10+a)*10+b)) [((xb*10+b)*10+c), ((xc*10+c)*10+d), ((xd*10+d)*10+e), ((xe*10+e)*10+a)],
			(sum $ map (\x -> (length.show) x) [a,b,c,d,e])*2 + 
				(sum $ map (\x -> (length.show) x) [xa,xb,xc,xd,xe]) == 16 ]

main = mapM_ (putStrLn . show) ring
