import Data.Bits
import Data.Char
import Math.NumberTheory.Primes
import Math.NumberTheory.Powers
import Debug.Trace

digitToBin :: Int -> Int
digitToBin n = [ 119, 36, 93, 109, 46, 107, 123, 39, 127, 111, 0 ] !! n

digestNum :: Int -> [Int]
digestNum n = map digitToInt (show n)

digitalRoot :: Int -> Int
digitalRoot n = sum (digestNum n)

dRList n = if length (show next) == 1
	then n:[next]
	else n:(dRList next) 
	where
		next = digitalRoot n

sam x = 2 * (sum
		$ map popCount
		$ map digitToBin
		$ concat
		$ map digestNum
		$ dRList x)

max x = snd $ foldl digest ([0],0) $ map (map digitToBin) ((map digestNum (dRList x)) ++ [[10]])
	where
		digest (a,x) b = if length a > length b
						then digest (a,x) (equal a b)
					else if length b > length a
						then digest ((equal b a),x) b
					else ( b, x + countOff + countOn )
						where
							switchOff = zipWith (.&.) a b
							countOff = if sum a == 0
								then 0
								else
									--trace ("\n::: " ++ (show a) ++ " " ++ (show b) ++ " " ++ (show switchOff))
									(sum (map popCount a)) - (sum (map popCount switchOff))
							switchOn = zipWith xor switchOff b
							countOn = if sum b == 0
								then 0
								else sum $ map popCount switchOn
		-- equal assumes left list is longer than right
		equal a b = (replicate ((length a)-(length b)) 0) ++ b

main = mapM_ (putStrLn . show) $ scanl1
									(\(_,_,_,d) (e,f,g,h) -> (e,f,g,d+h))
									(map
										(\x -> (x,(sam x),(Main.max x),(sam x)-(Main.max x)))
										(takeWhile (<2*(10^7)) (map fromIntegral (sieveFrom (10^7)))) )
