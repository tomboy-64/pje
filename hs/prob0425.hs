import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List
import Debug.Trace
import System.IO

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
--			++ [ a ++ [y] | y <- [0..9] ]
--			++ [(init a)]
			++ [(tail a)]
			-- condition 1
			++ (concatMap (\i -> replace a i) [0..((length a)-1)])
			where	replace :: [Int] -> Int -> [[Int]]
				replace xs i = map (\n -> (take i xs) ++ [n] ++ (drop (i+1) xs)) [9,8..0]
				a :: [Int]
				a = digits n

{-allReachable :: [Int] -> [Int] -> Int -> [Int]
allReachable [] inPath@(inPathLower, inPathHigher) _ _ = inPath
allReachable candidates inPath@(inPathLower, inPathHigher) tested upperBound = check (lookup (candidates !! 0) allReplacements)
	where check x = case x of
		Nothing -> allReachable (tail candidates) inPath (insert x tested) upperBound
		Just a -> allReachable (tail candidates) -}

allReachBl :: [Int] -> [Int] -> Int -> Bool
allReachBl [] _ _ = False
allReachBl (2:_) _ _ = True
allReachBl candidates tested upperBound = check (lookup bugger allReplacements)
	where	check x = case x of
			Nothing	-> allReachBl (tail candidates) (insert bugger tested) upperBound
			Just a	-> --trace ("candidate: " ++ (show bugger) ++ "\nnewCands: " ++ (show newCands) ++ "\ntested: " ++ (show tested)) $
				allReachBl newCands (insert bugger tested) upperBound
				where	newCands = nub $ sort
						$ filter (\x -> and [ (x < upperBound), not (elem x (takeWhile (<upperBound) tested)), x /= (head candidates)])
						$ a ++ (tail candidates)
		bugger = candidates !! 0

isRel n = rel (lookup n allReplacements)
	where rel x = case x of
		Nothing -> False
		Just a	-> allReachBl a [] n

is2sRelative :: Int -> Bool
is2sRelative n = rel (lookup n allReplacements) [n]
	where	rel x b = case x of
			Nothing	-> False
			Just a 	-> if 2 == (a !! 0)
				then trace ((show n) ++ ": 2 <-> " ++ (concat (map (\x -> (show x) ++ " <-> ") (init b))) ++ (show (last b)))
					True
--				else or (map 
--					(\x -> rel (lookup x allReplacements) (x:b))
--					(filter (\x -> not (elem x b)) (takeWhile (<n) a))
--					)
				else or $ map 
					(\x -> secRel (lookup x allRelatives) x (x:b))
					(filter (\x -> not (elem x b)) (takeWhile (<n) a))
		secRel :: Maybe Bool -> Int -> [Int] -> Bool
		secRel x y b = case x of
			Just True -> True
			Just False -> rel (lookup y allReplacements) (y:b)
			

allRelatives = zip myPrimes (map is2sRelative myPrimes)

f n = filter (not . isRel) (takeWhile (<n) myPrimes)
--f n = map isRel (takeWhile (<n) myPrimes)


--main = putStr("Result: " ++ show( sum( f 10000000 ) ) );
--main = putStr $ show $ isRel 10000000
main = do
	hSetBuffering stdout NoBuffering
	putStr $ show $ f 1000000
