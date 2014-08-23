import Math.NumberTheory.Powers
import Data.Ratio
import Data.List

theDs :: [Int]
theDs = filter (\x -> (not.isSquare) x && x/=61 && x/=97) [2..1000]

results :: [(Int,Int)]
results = zip theDs (map dioEq theDs)

dioEq :: Int -> Int
dioEq d = solveY 2
	where
		solveY x = if ((x^2)-1) % d == myFrac % 1 && isSquare myFrac
			then x
			else solveY (x+1)
			where
				myFrac = (((x^2)-1) `div` d)

main = mapM_ (putStrLn . show) results
