import Debug.Trace

-- n = 18

splitMeUpScotty :: ((Int,Int),(Int,Int)) -> [((Int,Int),(Int,Int))]
splitMeUpScotty myAll@((a,b),(c,d)) = if snd dmx == 0 && snd dmy == 0 && c-a == d-b
							then
								--trace ("split up: " ++ (show ((a,b),(c,d))))
								[ Main.flip ((a,d),(xX-1,xY))
								, ((xX,xY),(c,d))
								, ((a,b),(xX-1,xY-1))
								, Main.flip ((xX,xY-1),(c,b))
								]
							else
								error ("Something went wrong with division: " ++ (show myAll))
							where
								xX = (fst dmx) + a
								dmx = divMod (c+1-a) 2
								xY = (fst dmy) + b
								dmy = divMod (d+1-b) 2

-- flip turns the box (left upper, right lower) to standard (left lower, right upper) corners.
flip :: ((Int,Int),(Int,Int)) -> ((Int,Int),(Int,Int))
flip ((a,d),(c,b)) = ((a,b),(c,d))

checkForBW :: ((Int,Int),(Int,Int)) -> Int -> Int
checkForBW myAll@((a,b),(c,d)) n =
								if and [ nw == se, nw == sw, nw == ne ]
									then 2
									else 1 + (sum (map (\v -> checkForBW v n) (splitMeUpScotty myAll)))
										where
											sw = (formula a b n)
											se = (formula a d n)
											nw = (formula c b n)
											ne = (formula c d n)

formula :: Int -> Int -> Int -> Int
formula x y n = if (x-2^(n-1))^2 + (y-2^(n-1))^2 <= 2^(2*n-2)
			then 0
			else 1

result :: Int -> Int
result n = 1 + (sum (map (\v -> checkForBW v n) (splitMeUpScotty ((0,0),(2^n-1,2^n-1)))))

main = mapM_ (putStrLn.show) $ zip [24..24] (map result [24..24])
