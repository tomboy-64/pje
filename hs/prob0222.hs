import Data.List
import Data.Maybe

distances :: [((Int,Int),Double)]
distances = [ ((a,b),c) |
					a <- [30..49],
					b <- [(a+1)..50],
					let c = sqrt(fromIntegral(a+b)) - sqrt(fromIntegral(100-a-b)) ]

possibilities = permutations [30..50]

recursion = foldl addUp 0 possibilities
	where
		addUp mini poss = rec poss (fromIntegral(head poss))
			where
				rec :: [Int] -> Double -> Double
				rec (a:b:bs) acc =
					if result > mini
						then mini
						else next
							where
								result = disB + (fromIntegral lastOne) + acc
								disB = if a>b
										then fromJust $ lookup (b,a) distances
										else fromJust $ lookup (a,b) distances
								lastOne = if bs == []
										then b
										else 0
								next = if bs == []
										then result
										else rec (b:bs) result

main = (putStrLn . show) recursion
