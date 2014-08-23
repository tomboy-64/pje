import System.IO
import Data.Ord
import Data.List
import Debug.Trace

main :: IO ()
main = do 
	inh <- openFile "matrix.txt" ReadMode
	inpStr <- hGetContents inh
	let matrix = processData inpStr
	let result = processMatrix matrix
	(putStrLn.show) result
--	mapM_ (putStrLn.show.length) matrix
--	(putStrLn.show.length) matrix
	hClose inh

processData :: String -> [[Int]]
processData input = map (\x -> read ("["++x++"]")) (lines input)

processMatrix :: [[Int]] -> ((Int,Int),Int)
processMatrix matrix = pM initial []
	where
		myOrd :: ((Int,Int),Int) -> ((Int,Int),Int) -> Ordering
		myOrd ((v,w),a) ((x,y),b) = if a > b then GT
					else if a < b then LT
					else if v*w > x*y then LT
					else if v*w < x*y then GT
					else EQ
		coords :: (Int,Int) -> Int
		coords (a,b) = (matrix !! a) !! b

		initial :: [((Int,Int),Int)]
--		initial = sortBy myOrd $ map (\x -> ((x,0),coords (x,0))) [0..(length matrix)-1]
		initial = [((0,0),coords (0,0))]

		pM :: [((Int,Int),Int)] -> [((Int,Int),Int)] -> ((Int,Int),Int)
		pM (input:rest) discarded =
			if fst input == ((length matrix) -1, (length (head matrix)) -1)
			then input
			else
--				trace ((show (input))++(show (nextCoords input))++(show (head next)))
				pM next (input:discarded)
					where
						next = foldl newList rest (nextCoords input)
--						 (\list into -> insertBy myOrd into list) rest (nextCoords input)
						newList :: [((Int,Int),Int)] -> ((Int,Int),Int) -> [((Int,Int),Int)]
						newList b a = case lookup (fst a) discarded of
							Nothing		-> case lookup (fst a) b of
											Nothing -> insertBy myOrd a b
											Just x -> if x <= snd a
												then b
												else insertBy myOrd a (deleteBy (\(x,_) (y,_) -> x==y) a b)
							Just x		-> if x <= snd a
												then b
												else insertBy myOrd a b


		
		nextCoords ((a,b),z) = up ++ down ++ right ++ left
			where
				up = if a > 0
					then [ ((a - 1, b),(z + (coords (a-1,b)))) ]
					else []
				down = if a < (length matrix) -1
					then [ ((a + 1, b),(z + (coords (a+1,b)))) ]
					else []
				right = if b < (length (matrix !! 0)) -1
					then [ ((a, b+1),(z + (coords (a,b+1)))) ]
					else []
				left = if b > 0
					then [ ((a, b-1),(z + (coords (a,b-1)))) ]
					else []
