import Data.Ratio
import Math.NumberTheory.Primes.Testing
import Debug.Trace

nextRound starter distance = map (\x -> starter + (distance*x)) [1..4]

iterator :: Int -> Int -> [Int] -> Int
iterator starter distance acc =
	if myRat < 0.1
	then (distance + 1)
	else
	--	trace ((show myRat) ++ " " ++ (show (realToFrac myRat)))
		iterator letzter (distance + 2) nextAcc
	where
		letzter = last(nextRound starter distance)
		nextAcc = acc ++ (filter (isPrime . fromIntegral) (nextRound starter distance))
		myRat = (length nextAcc) % ((distance *2)+1)

main = (putStrLn . show) (iterator 1 2 [])
