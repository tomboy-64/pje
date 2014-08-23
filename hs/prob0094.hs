import Math.NumberTheory.Powers

cSides = [2,4..]

bothSides = concat $ map (\y -> [(y, y-1), (y,y+1)]) $ takeWhile (\x -> 3*x-2 <= 1000000000) cSides

almostResult [] results = results
almostResult x results = if isSquare $ (\(a,b) -> (b^2 - (a `div` 2)^2)) $ head bothSides
	then almostResult
			(dropWhile (\y -> snd y < 3*(snd $ head x)) bothSides)
			(results ++ [(fst (head x), snd (head x), (fst (head x))+2*(snd (head x)))])
	else almostResult
			(tail bothSides)
			results
--filter (\(a,b) -> isSquare (b^2 - (a `div` 2)^2)) bothSides


--result x = if 

--map (\(c,d) -> (c,d,c+2*d)) $ 

main = mapM_ (putStrLn.show) (almostResult bothSides [])
