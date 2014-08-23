import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List
import Debug.Trace
import System.IO
import qualified Data.IntMap as D


myPrimes :: [Int]
myPrimes = [ fromIntegral(x) | x <- takeWhile (<=10000000) primes]

digits :: Int -> [Int]
digits n = digits' n []
	where digits' n xs
		| n >= 10	= digits' (n `div` 10) [(n `mod` 10)] ++ xs
		| otherwise	= n:xs

makeNumber :: [Int] -> Int
makeNumber [] = 0
makeNumber xs = foldl1 (\n m -> (n*10) + m) xs

testPrime :: Int -> Bool
testPrime n = isPrime (fromIntegral(n)) 

allReplacements :: [(Int, [Int])]
allReplacements = zip myPrimes (map replacements myPrimes) 
	where	replacements :: Int -> [Int]
		replacements n = sort
			$ nub
			$ filter (\x -> and [ x/=0, testPrime x ])
			$ map makeNumber
			$ filter (\x -> and [ not ( null x ), head x /= 0 ] )
			$ [ w:a | w <- [1..9] ]
			++ [(tail a)]
			-- condition 1
			++ (concatMap (\i -> replace a i) [0..((length a)-1)])
			where	replace :: [Int] -> Int -> [[Int]]
				replace xs i = map (\n -> (take i xs) ++ [n] ++ (drop (i+1) xs)) [9,8..0]
				a :: [Int]
				a = digits n

isRel :: Int -> Int -> D.IntMap(Bool, Int, [Int]) -> (Bool, D.IntMap(Bool, Int, [Int]))
isRel n upperBound myMap = --do trace ("n: " ++ (show n) ++ " uB: " ++ (show upperBound) ++ " mMap: " ++ (show myMap))
		case (D.lookup n myMap) of
		Nothing							-> case newCandidates of
			Nothing -> error "Fucker. Why are you Nothing?"
			Just a	-> isRel n upperBound (D.insert n (False, 0, a) myMap)
			where newCandidates = lookup n allReplacements
		Just (True,_,_)					-> (True, myMap)
		Just (_,_,(2:_))				-> (True, D.insert n (True, upperBound, []) myMap)
		Just (False,_,[])				-> (False, myMap)
		Just (False, upToVal, testLeft)	-> if null(candidates)
			then --trace ("candidates: " ++ (show candidates) ++ "n/uB: " ++ (show n) ++ (show upperBound)) 
				(False, (D.insert n (False, upperBound, (dropWhile (<=upperBound) testLeft)) myMap))
			else foldl check (False, myMap) candidates
				where	candidates = takeWhile (<upperBound) testLeft

					check :: (Bool, D.IntMap(Bool, Int, [Int])) -> Int -> (Bool, D.IntMap(Bool, Int, [Int]))
					check (hit,newmap) test = do
							let modified = isRel test upperBound newmap
							( or [ hit, fst modified ], snd modified)

{-					toBeOrNot :: Maybe (Bool, Int, [Int]) -> (Bool,
					toBeOrNot x = case x of
							Nothing -> error "Y U NO jUST?"
							Just b@(a,_,_) -> (a,b)-}

					newLeft :: Maybe (Bool, Int, [Int]) -> [Int]
					newLeft x 	= case x of
							Nothing -> error "Fucker. Why are you nothing?"-- we have looped over that one already, so it must be there!
							Just (_,_,a)	-> dropWhile (<= upperBound) a

--f n = filter (not . isRel) (takeWhile (<n) myPrimes)
g n = g' D.empty (takeWhile (<=n) myPrimes)
	where	g' _ [] = []
		g' myMap (a:myList) = if not (fst(isRel a a myMap))
				then a:(g' (snd(isRel a a myMap)) myList)
				else g' (snd(isRel a a myMap)) myList
--		g' a b = trace ("one" ++ (show a) ++ "two" ++ (show b)) [666]

--f n = map isRel (takeWhile (<n) myPrimes)


--main = putStr("Result: " ++ show( sum( f 10000000 ) ) );
--main = putStr $ show $ isRel 10000000
main = do
	hSetBuffering stdout NoBuffering
--	putStr $ show $ f 1000000
