import qualified Data.HashMap.Lazy as H
import Data.List
import Math.NumberTheory.Primes.Testing
import Math.NumberTheory.Primes.Sieve
import Debug.Trace
import Data.Maybe

initiator = [0..3]


toPrimes :: [Int] -> [Int]
toPrimes x = map (\a -> fromIntegral (primes !! a)) x

newLists :: [Int] -> [(Int,[Int])]
newLists x = map (\a -> (fromIntegral (sum $ toPrimes a), a))
		$ filter hasNoDupes
		$ map newList initiator
	where
		newList :: Int -> [Int]
		newList y = (take y x) ++ [(x!!y)+1] ++ (drop (y+1) x)
		hasNoDupes x = rec x (-1)
			where
				rec [] _ = True
				rec (x:xs) bef = if x == bef
					then False
					else rec xs x


recursor :: [(Int,[Int])] -> H.HashMap (Int,Int) Bool -> (Int,[Int])
recursor (input:rest) lookilook = if fst update
	then input
	else
		trace (show input)
		recursor (combine rest (newLists (snd input))) (snd update)
		where
			update :: (Bool, H.HashMap (Int,Int) Bool)
			update = foldl upd2 (True, lookilook) (filter (\x -> length x == 2) (subsequences (snd input)))
				where
					upd2 :: (Bool, H.HashMap (Int,Int) Bool) -> [Int] -> (Bool, H.HashMap (Int,Int) Bool)
					upd2 (a, looki) (ba:bb:_) =
						if not a
						then (False, looki)
						else case H.lookup (ba,bb) looki of
							Nothing -> (check (ba,bb), H.insert (ba,bb) (check (ba,bb)) looki)
							Just x -> (x, looki)
check :: (Int,Int) -> Bool
check (a,b) = and
	$ map isPrime
	$ [ (read ((show (primes!!a)) ++ (show (primes!!b)))), (read ((show (primes!!b)) ++ (show (primes!!a)))) ]

combine :: [(Int,[Int])] -> [(Int,[Int])] -> [(Int,[Int])]
combine a [] = a
combine a (b:bs) = if b `elem` a
			then combine a bs
			else combine (insertBy myOrd b a) bs

myOrd :: (Int,[Int]) -> (Int,[Int]) -> Ordering
myOrd (a,_) (b,_) = if a<b then LT
					else if a>b then GT
					else EQ

binaries = [[]] ++ [[ ((x,y),(sum (toPrimes [x,y]),check(x,y))) |
						y <- [0..x-1] ]|
						x <- [1..]]
isVBin (a,b) = (snd . snd) ((binaries !! a) !! b)
sumVal (a,b) = (fst . snd) ((binaries !! a) !! b)
retrieveBin (a,b) = ((binaries !! a) !! b)

binariesInOrder = bIO [(1,0)] [(2,0)]
	where
		bIO :: [(Int,Int)] -> [(Int,Int)] -> [(Int,Int)]
		bIO this next = (filter isVBin this)
						++ bIO
							(filter selBySumVal next)
							(getNext next [])
			where
				selBySumVal val = sumVal val == minSumVal
				minSumVal = minimum (map sumVal next)
				getNext [] acc = acc
				getNext (a:as) acc =
						if sumVal a == minSumVal
						then
							if as == [] && snd a == 0
							then
								if (fst a)-(snd a) <= 1
								then getNext [] (acc ++ [((fst a)+1,0)])
								else getNext [] (acc ++ [((fst a),(snd a)+1),((fst a)+1,0)])
							else
								if (fst a)-(snd a) <= 1
								then getNext as acc
								else getNext as (acc ++ [((fst a),(snd a)+1)])
						else getNext as (acc ++ [a])

trinaries = map
				(\x -> map
						(\yz@(y,z) -> ((x,y,z),
										((fromIntegral(primes !! x))+(sumVal yz),
										check(x,y) && check(x,z))))
						(filter (\(v,_) -> v<x)
							(takeWhile
								(\a -> sumVal a < fromIntegral(primes!!(x-1)+(primes!!(x-2))))
								binariesInOrder)
						)
				)
				[4..]

isVTri (a,b,c) = isVBin(a,c) && isVBin(a,b)
isVTri' (_,(_,a)) = a
sumVTri (a,b,c) = (fromIntegral(primes !! a)) + (fst . snd) ((binaries !! b) !! c)

trinariesInOrder = tIO (head trinaries) (tail trinaries)
	where
		tIO :: [((Int,Int,Int),(Int,Bool))] -> [[((Int,Int,Int),(Int,Bool))]] -> [((Int,Int,Int),(Int,Bool))]
		tIO this next = (filter isVTri' this)
						--this
						++ tIO
							next1
							(next2 ++ (snd divide))
			where
				sumVal x = (fst . snd) x
				divide = span (\x -> sumVal (head x) <= sumVal (head (head next))) next
				minSumVal = minimum $ map sumVal $ map head (fst divide)
				next1 = filter (\x -> sumVal x == minSumVal) (map head (fst divide))
				next2 = filter (not.null) $ map (\x -> filter (\y -> sumVal y /= minSumVal) x) (fst divide)
trinariesInOrder' = map fst trinariesInOrder

quartetts = map
				(\w -> map
						(\xyz@(x,y,z) -> ((w,x,y,z),
										((fromIntegral(primes !! w))+(sumVTri xyz),
										check(w,x) && check(w,y) && check(w,z))))
						(filter (\(v,_,_) -> v<w)
							(takeWhile
								(\a -> sumVTri a < fromIntegral(primes!!(w-1)+(primes!!(w-2))+primes!!(w-3)))
								trinariesInOrder')
						)
				)
				[19..]

isVQuad' (_,(_,a)) = a
sumVQuad (a,b,c,d) = (fromIntegral(primes !! a)) + (fromIntegral(primes !! b)) + (fst . snd) ((binaries !! c) !! d)

quartettsInOrder = qIO (head quartetts) (tail quartetts)
	where
		qIO :: [((Int,Int,Int,Int),(Int,Bool))] -> [[((Int,Int,Int,Int),(Int,Bool))]] -> [((Int,Int,Int,Int),(Int,Bool))]
		qIO this next = (filter isVQuad' this)
						--this
						++ qIO
							next1
							(next2 ++ (snd divide))
			where
				sumVal x = (fst . snd) x
				divide = span (\x -> sumVal (head x) <= sumVal (head (head next))) next
				minSumVal = minimum $ map sumVal $ map head (fst divide)
				next1 = filter (\x -> sumVal x == minSumVal) (map head (fst divide))
				next2 = filter (not.null) $ map (\x -> filter (\y -> sumVal y /= minSumVal) x) (fst divide)
quartettsInOrder' = map fst quartettsInOrder

quintetts = map
				(\v -> map
						(\wxyz@(w,x,y,z) -> ((v,w,x,y,z),
										((fromIntegral(primes !! v))+(sumVQuad wxyz),
										check(v,w) && check(v,x) && check(v,y) && check(v,z))))
						(filter (\(u,_,_,_) -> u<v)
							(takeWhile
								(\a -> sumVQuad a < fromIntegral(primes!!(v-1)+(primes!!(v-2))+primes!!(v-3)+primes!!(v-4)))
								--quartettsInOrder')
								precomputed)
						)
				)
				--[122..]
				[122..2000]

isVQuin' (_,(_,a)) = a
sumVQuin (a,b,c,d,e) = (fromIntegral(primes !! a))
						+ (fromIntegral(primes !! b))
						+ (fromIntegral(primes !! c))
						+ (fst . snd) ((binaries !! d) !! e)

quintettsInOrder = qQIO (head quintetts) (tail quintetts)
	where
		qQIO :: [((Int,Int,Int,Int,Int),(Int,Bool))]
				-> [[((Int,Int,Int,Int,Int),(Int,Bool))]]
				-> [((Int,Int,Int,Int,Int),(Int,Bool))]
		qQIO this next = (filter isVQuin' this)
						--this
						++ qQIO
							next1
							(next2 ++ (snd divide))
			where
				sumVal x = (fst . snd) x
				divide = span (\x -> sumVal (head x) <= sumVal (head (head next))) next
				minSumVal = minimum $ map sumVal $ map head (fst divide)
				next1 = filter (\x -> sumVal x == minSumVal) (map head (fst divide))
				next2 = filter (not.null) $ map (\x -> filter (\y -> sumVal y /= minSumVal) x) (fst divide)
quintettsInOrder' = map fst quintettsInOrder


main = mapM_ (putStrLn.show) $ take 1 quintettsInOrder

--precomputed = [(121,28,3,1),(351,18,11,1)]
--precomputed :: [(Int,Int,Int,Int)]
precomputed = [(121,28,3,1),(351,18,11,1),(311,86,6,1),(285,131,8,4),(519,24,7,3),(341,311,4,1),(341,311,6,1),(399,153,112,56),(610,24,7,3),(572,99,3,1),(449,263,17,3),(519,203,7,3),(338,307,187,10),(504,232,83,3),(777,18,11,1),(665,177,27,23),(572,351,11,1),(701,102,86,80),(826,86,6,1),(852,86,6,1),(815,202,10,7),(767,191,141,19),(822,112,106,90),(778,344,14,8),(700,307,187,10),(822,349,23,8),(1090,125,4,1),(1111,92,17,3),(1075,166,10,7),(724,575,14,8),(618,542,154,77),(1194,41,10,7),(1085,202,11,1),(1061,220,24,13),(1029,311,4,1),(1085,265,11,1),(1077,143,141,63),(1090,311,4,1),(1173,112,90,61),(509,496,296,272),(1090,311,42,1),(1173,112,106,90),(763,504,336,3),(796,362,287,249)]
