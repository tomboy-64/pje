import System.IO
import Data.Sequence as S
import Data.List as L
import Data.Maybe
import Data.Set as Set
import Math.NumberTheory.Primes.Factorisation

dimensions :: Integer -> [(Integer,Integer)]
dimensions n =	L.map (\x -> (x, n `div` x)) (
				L.sort (
				nub (
				L.filter (\x -> x^2 <= n) (
				L.map product (
				L.subsequences (
				toAscList (
				Set.filter (\x -> x^2 <= n) (
				divisors n))))))))

allRooms n = toAscList (S.replicateA n (S.fromList [True,False]))

verboseRoom :: (Integer,Integer) -> [Bool] -> Maybe [[Int]] -- this checks the bitmask against sanity
verboseRoom dim@(a,b) c = vR' c [1..] (0,0) (L.replicate (fromInteger a) (L.replicate (fromInteger b) 0))
	where
		vR' [] _ _ acc = Just acc
		vR' tat@(c:cs) mark@(d:ds) (y,x) acc =
			if x == b										-- go to next row
			then vR' tat mark (y+1,0) acc
			else if y > a-1
				then error "more rows than possible?"
				else if c											-- horizontal tatami 
						&& x <= (b-2)								-- enough space left 
					then if ((acc!!a)!!b) + ((acc!!a)!!(b+1)) == 0	-- the cells are actually still free
						then vR' cs ds (y,x+2) (Main.update y (updateH x d (acc!!y)) acc)
						else if ((acc!!a)!!b) == 0
							then Nothing
							else vR' tat mark (y,x+1) acc
					else if (not c)										-- vertical tatami
							&& y <= (a-2)								-- enough space left
						then if ((acc!!a)!!b) + ((acc!!(a+1))!!b) == 0	-- the cells are actually still free
							then vR' cs ds (y,x+1) ((L.take y acc) ++ (updateV x d (acc!!y) (acc!!(y+1))) ++ (L.drop (y+2) acc))
							else if ((acc!!a)!!b) == 0
								then Nothing
								else vR' tat mark (y,x+1) acc
						else Nothing
				

update :: Int -> a -> [a] -> [a]
update ind replacement list = (L.take ind list) ++ [replacement] ++ (L.drop (ind+1) list)
updateH :: Int -> a -> [a] -> [[a]]
updateH ind replacement list = [ Main.update (ind+1) replacement (Main.update ind replacement list) ]
updateV :: Int -> a -> [a] -> [a] -> [[a]]
updateV ind replacement list1 list2 = [ Main.update ind replacement list1, Main.update ind replacement list2 ]

-- This checks whether this room has 4 tatamis colliding
-- True: 
roomTest :: [[Int]] -> Bool 
roomTest room@(a:as) = test [0..((L.length room)-2)] [0..((L.length a)-2)]
	where
		test []			_		= True
		test (y:ys)		[]		= test ys [0..((L.length a)-2)]
		test ys@(y:_)	(x:xs)	= if test4 ((room!!y)!!x) ((room!!(y+1))!!x) ((room!!y)!!(x+1)) ((room!!(y+1))!!(x+1))
			then test ys xs
			else False
				where
					test4 w x y z = or [ w==x, w==y, x==z, y==z ] -- this yields false it means 4 edges collide

-- this checks all possible geometries of a given size
tfree :: Integer -> Integer
tfree n = sum (L.map (\x -> isFree n x) (dimensions n))

-- this returns whether a room with a given geometry is tatami-free
isFree n dim = if (L.length (
			L.filter roomTest (
			catMaybes (
			L.map (\x -> verboseRoom dim x) (allRooms n))))) >= 1
	then 1
	else 0
