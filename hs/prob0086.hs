import Data.List
import Math.NumberTheory.Powers
limit :: Int
limit = 2000

cubes :: Integer -> [(Integer,Integer,Integer)]
cubes m = [ (a,b,m) |
				b <- [1..m],
				a <- [1..b] ]

shortests :: Integer -> [Integer]
shortests m = map short (cubes m)
	where
		short (a,b,c) = minimum [
							(a+b)^2 + c^2,
							(a+c)^2 + b^2,
							(b+c)^2 + a^2 ]

analyze :: [Integer] -> [(Integer,Int)] -> [(Integer,Int)]
analyze [] output = output
analyze (i:input) output = case lookup i output of
	Nothing -> if isSquare i
					then analyze input ((i,1):output)
					else analyze input ((i,0):output)
	Just x -> if x == 0
					then analyze input output
					else analyze input ((i,x+1):(deleteBy remKey (i,0) output))
		where
			remKey :: (Integer,a) -> (Integer,a) -> Bool
			remKey (a,_) (b,_) = a==b

result m anOutputs = ((sum $ map (\(_,x) -> x) $ thingy), thingy)
	where
		thingy = analyze (shortests m) anOutputs

whatIWant = rec 1 0 []
	where
		rec m acc anOutputs = if acc + (fst thingy) > limit
				then (m, acc+(fst thingy))
				else rec (m+1) (acc+(fst thingy)) (snd thingy)
			where
				thingy = result m anOutputs


main = (putStrLn . show) $ whatIWant
