import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Debug.Trace
import Data.List
import Data.Ord
import qualified Data.Set as S

initiator = [0..3]

testList a = and $
						map isPrime
						$ map (\[a,b] -> (read ((show (primes!!a)) ++ (show (primes!!b)))))
						$ concatMap (\x -> [x, reverse x])
						$ filter (\x -> length x == 2)
						$ subsequences a

nextPrime z = z+1 --head $ sieveFrom (z+1)

newPrimeLists :: [Int] -> [(Int,[Int])]
newPrimeLists x = map (\a -> (fromIntegral (sum $ toPrimes a), a))
					$ filter hasNoDupes
					$ map newList initiator
			where
				newList :: Int -> [Int]
--		newList y = (take y x) ++ [nextPrime (x!!y)] ++ (drop (y+1) x)
				newList y = (take y x) ++ [(x!!y)+1] ++ (drop (y+1) x)

toPrimes x = map (\a -> fromIntegral (primes !! a)) x

hasNoDupes x = rec x (-1)
	where
		rec [] _ = True
		rec (x:xs) bef = if x == bef
							then False
							else rec xs x

recursor :: [(Int,[Int])] -> Set (Int,Int,Bool) -> (Int,[Int])
recursor lists lookilook = if testList (snd (head lists)) lookilook
			then head lists
			else
				trace (show (take 2 lists))
				$ recursor (combine (tail lists) (newPrimeLists (snd (head lists)))) lookilook
				where
					testIt 

frst (a,_,_) = a
scnd (_,a,_) = a
thrd (_,_,a) = a

combine :: [(Int,[Int])] -> [(Int,[Int])] -> [(Int,[Int])]
combine a [] = a
combine a (b:bs) = if b `elem` a
			then combine a bs
			else combine (insertBy myOrd b a) bs

myOrd :: (Int,[Int]) -> (Int,[Int]) -> Ordering
myOrd (a,_) (b,_) = if a < b
			then LT
			else if a > b
			then GT
			else EQ

main = (putStrLn . show) (recursor [(fromIntegral (sum $ toPrimes initiator), initiator)] S.empty)
