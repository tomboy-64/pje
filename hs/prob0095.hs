import qualified Data.Set as S
import Math.NumberTheory.Primes.Factorisation
import Data.Maybe
import Debug.Trace

properDivs :: Integer -> [Integer]
properDivs x = S.toList $ S.delete x $ divisors x

allDivs :: [Int]
allDivs = 0:(map (\x -> sum $ map fromIntegral $ properDivs x) [1..])

{-startChain a = chain 1 a S.empty
	where
		chain lngth mini loophole@(next:_) =
			if realNext == a
				then Just (lngth, mini,a)
			else if realNext > 1000000 || realNext `elem` loophole
				then Nothing
				else if realNext < mini
					then chain (lngth+1) realNext (realNext:loophole)
					else chain (lngth+1) mini (realNext:loophole)
			where
				realNext = allDivs !! next
-}
--allChains = catMaybes (map startChain [1..1000000])

newChain = chain [2] 1 1 S.empty []
	where
		chain elements@(a:_) lngth mini burnt results =
			if length elements == 1 && head elements >= 1000000
				then results
			else if length elements > 1 && a == last elements
				then
						trace ("New: " ++ (show $ [(lngth, mini, a)]) ++ " " ++ (show (a+1)))
							chain [(last elements) +1]
							1
							0
--							(S.fromList (map (\(_,_,a) -> a) results))
							S.empty
							(results ++ [(lngth,mini,a)])
			else if realNext > 1000000 || realNext < last elements
				then
--						trace ("abort: " ++ (show (a)) ++ " - " ++ (show(last elements)))
							chain [(last elements) +1]
							1
							0
							(S.fromList (map (\(_,_,a) -> a) results))
							results
			else if realNext < mini
				then
--						trace ("iter (new mini): " ++ (show (a)) ++ " - " ++ (show(last elements)))
							chain (realNext:elements)
							(lngth+1)
							realNext
--							(S.insert a burnt)
							S.empty
							results
				else
--						trace ("iter (old mini): " ++ (show (a)) ++ " - " ++ (show(last elements)))
							chain (realNext:elements)
							(lngth+1)
							mini
							(S.insert a burnt)
							results
			where
				realNext = allDivs !! a

main = mapM_ (putStrLn . show) newChain
