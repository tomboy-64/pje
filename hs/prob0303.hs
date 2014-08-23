import Data.List
import Debug.Trace



f :: Integer -> Integer
{-f n = rec 1
	where
		rec :: Int -> Int
		rec m = if check attempt
			then
				--trace (show attempt)
				attempt
			else	
				--trace (show attempt)
				rec (m+1)
				where
					attempt :: Int
					attempt = m*n
					-}
f n = if and (map (=='9') (show n))
	then read ((replicate (length (show n)) '1') ++ (replicate ((length (show n))*4) '2'))
	else if last(show n) == '0'
		then 10*(f (n`div`10))
		else rec 0 [(0,0)]
	where
		nextDigits :: [[Integer]]
		nextDigits = map (\z -> map fromIntegral $ elemIndices z
										(map
											(\x -> rem 
													((rem n 10) * x)
													10)
											[0..9])
									) [0..9]
		nDFrom :: Integer -> [Integer]
		nDFrom x =
					--trace (show x)
					concat
					$ map (\y -> nextDigits !! (fromIntegral y))
					$ map (\y -> rem (y-x) 10) [10, 11, 12]
		rec tier values = if (not.null) sherman
					then
						--trace ("done: " ++ (show sherman) ++ "\n" ++ (show (length worker)))
						minimum sherman
					else
						rec (tier+1) mathilda
			where
				worker :: [(Integer,Integer)]
				worker = concat $ map nextVals values
				nextVals :: (Integer,Integer) -> [(Integer,Integer)]
				nextVals (a,b) =
								--trace (show (a,b)) 
								map
									(\x ->
										((x*(10^tier) + a),(x*(10^tier)*n)+b)
									)
									(nDFrom (rem (b `div` (10^tier)) 10))
				nNFilt (a,b) = a/=0 || b/=0
				mathilda = filter nNFilt worker
				sherman = filter check (map snd mathilda)

check :: Integer -> Bool
check a = if a == 0
	then False
	else chk a
		where
			chk 0		= True
			chk x = if snd dm <= 2
				then chk (fst dm)
				else False
					where
						dm = divMod x 10

f2 (a,b,c,d) e = (e, f e, (f e)`div` e, d+((f e)`div` e))

result = scanl f2 (0,0,0,0) [1..10000]

main = mapM_ (putStrLn . show) result
