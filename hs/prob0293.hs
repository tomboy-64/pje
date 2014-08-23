import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Factorisation
import Math.NumberTheory.Primes.Testing
import qualified Data.Set as S

isPowerOf2 n = if n == 2
	then True
	else if snd dm2 == 0
		then isPowerOf2 (fst dm2)
		else False
	where
		dm2 :: (Int,Int)
		dm2 = divMod n 2

criterionNo3 :: Int -> Bool
criterionNo3 n = stage1 (fromIntegral n) primes []
		where
			stage1 :: Integer -> [Integer] -> [Integer] -> Bool
			stage1 remainder (p:rimes) found =
				if snd dm == 0
					then if fst dm == 1
						then if length found == 0
							then False
							else True
						else stage1 (fst dm) rimes (p:found)
					else
						if length found == 0
							then stage1 remainder rimes found
						else if length found == 1 && found /= [2]
							then False
						else stage2 remainder found
					where
						dm = divMod remainder p
			stage2 :: Integer -> [Integer] -> Bool
			stage2 remainder rest@(p:rimes) = 
				if snd dm == 0
					then if fst dm == 1
						then True
						else stage2 (fst dm) rest
					else if rimes == []
						then False
						else stage2 remainder rimes
					where
						dm = divMod remainder p

admissibles = 2:(filter (\x -> criterionNo3 x) [4,6..10^9])

pseudoFortune :: Int -> Int
pseudoFortune x = ((fromIntegral.head) (sieveFrom (fromIntegral x+2))) - x

mainLoop :: S.Set Int -> [Int] -> IO ()
mainLoop collection []				= putStrLn ((show (sum (S.toList collection)))
												++ "\n"
												++ (show collection))
mainLoop collection (a:dmissibles)	= do 
		(putStrLn.show) (a, fortune)
		mainLoop (S.insert fortune collection) dmissibles
			where fortune = pseudoFortune a

main = mainLoop S.empty admissibles
