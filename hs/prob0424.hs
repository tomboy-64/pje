import System.IO
import Data.Char
import Data.List
import Debug.Trace

main :: IO ()
main = do 
       inh <- openFile "kakuro200.txt" ReadMode
       mainloop inh 
       hClose inh

mainloop :: Handle -> IO ()
mainloop inh = 
    do ineof <- hIsEOF inh
       if ineof
           then return ()
           else do inpStr <- hGetLine inh
--                   mapM_ (\x -> putStrLn(show x)) (parse inpStr)
                   putStrLn (show(parse inpStr))
                   error "just a test"
                   putStrLn("")
                   mainloop inh

-- first we parse shit
parse str = matrixOps ((createMatrix 'h') ++ (createMatrix 'v'))
		-- sL
		where
			dim :: Int
			dim = digitToInt(str!!0)
			sL :: [[Char]]
			sL = sL' (drop 2 str) [[str!!0]]
				where
					sL' :: [Char] -> [[Char]] -> [[Char]]
					sL' [] acc = acc
					sL' str acc = if isAsciiUpper(str!!0)
							then sL' (drop 2 str) (acc ++ [[(str!!0)]])
						else if (str!!0) == '('
							then sL'
								(drop 1 (dropWhile (/= ')') str))
								(acc ++ [(takeWhile (/= ')') (drop 1 str))])
						else if (str!!0) == ','
							then sL' (drop 1 str) acc
						else error ("this is no spoon: " ++ (take 3 str))
			createMatrix :: Char -> [[Int]]
			createMatrix a = if a == 'h'
					then foldl cHM' [] hIndex
				else if a == 'v'
					then foldl cHM' [] vIndex
				else error "This is no spoon!"
				where
					hIndex :: [Int]
					hIndex = [1..((dim^2))]
					vIndex :: [Int]
					vIndex = [ (x `mod` dim) * dim + (x `div` dim) +1 | x <- [0..((dim^2)-1)] ]
					cHM' :: [[Int]] -> Int -> [[Int]]
					cHM' acc x = --trace ("x: " ++ (show x) ++ "\n")
						cHM'' acc x
					cHM'' acc x =
						if head(sL!!x) == 'X'
							then acc
						else if a `elem` (sL!!x)
							then --trace ("sL!!x: " ++ (show (sL!!x)))
								acc ++ [zipWith (-) (replicate 60 0) (decSum (sL!!x) a)]
						else if 'h' `elem` (sL!!x) || 'v' `elem` (sL!!x)
							then acc
						else if head(sL!!x) == 'O'
							then update ((length acc)-1)
									acc
									$ update (x+10) (last acc) (((last acc)!!(x+10))+1)
						else if head(sL!!x) `elem` "ABCDEFGHIJ" && length(sL!!x) == 1
							then update ((length acc)-1)
									acc
									$ update (decLet(head(sL!!x))) (last acc) ((last acc)!!(decLet((head(sL!!x))))+1)
						else error ("Wtf is this? " ++ (show a) ++ " " ++ (show (sL!!x)))
							where
								decSum :: [Char] -> Char -> [Int]
								decSum x a = mkSumList (takeWhile isAsciiUpper (drop 1 (dropWhile (/= a) x))) (repeat 0)
								mkSumList :: [Char] -> [Int] -> [Int]
								mkSumList x acc = if length (x) > 1
										then mkSumList
											(tail x)
											(update (decLet (x!!0)) acc ((acc!!(decLet (x!!0)))+(10^(length(x)-1))))
									else if length (x) == 1
										then update (decLet (x!!0)) acc ((acc!!(decLet (x!!0)))+1)
									else error ("wtf is wrong with x?" ++ (show x))
											

decLet :: Char -> Int
decLet x = case (elemIndex x ['A'..'Z']) of
	Nothing -> error ("there is no such spoon " ++ (show x))
	Just a -> a
decInd :: Int -> Char
decInd x = ['A'..'Z'] !! x
update :: Int -> [a] -> a -> [a]
update ind list a = (take ind list) ++ [a] ++ (drop (ind+1) list)
remove :: Int -> [a] -> [a]
remove ind list = (take ind list) ++ (drop (ind+1) list)

				
--matrixOps a = soluteMatrix (filter (\x -> not (null x)) (tformMatrix (reduceMatrix a))) (reduceMatrix a)
matrixOps a = length $ filterPermuts (map (splitAt 10) (reduceMatrix a))
	where
		reduceMatrix :: [[Int]] -> [[Int]]
		reduceMatrix a = if (and (map checkLength (drop 1 a)))
			then foldl red' a [((length (a!!0))-1),((length (a!!0))-2)..10]
			else error ("Length of `a` inconsistent, shoot the programmer: " ++ show(map length a))
				where	checkLength :: [Int] -> Bool
					checkLength b = (length b) == (length (a!!0))
					red' :: [[Int]] -> Int -> [[Int]]
					red' matrix ind = if (and (map (\x -> (x!!ind) == 0) matrix))
						then map (remove ind) matrix
						else matrix
		tformMatrix :: [[Int]] -> [[Int]]
		tformMatrix a = tform [] 10
			where	tform :: [[Int]] -> Int -> [[Int]]
				tform matrix pivot = if (length (a!!0)) > pivot
					then if (length (validLines pivot)) >= 1
						then tform
							(matrix ++ [ wrapFurRed matrix pivot 0 ])
							(pivot+1)
						else error "validLines == []"
					else matrix
				validLines :: Int -> [[Int]]
				validLines ind = filter (\x -> (x!!ind) /= 0) a
				
				wrapFurRed matrix pivot tryThis = if (length(validLines pivot)) > tryThis
					then if (and (map ((==) 0) furCall))
						then --trace ("then " ++ (show pivot) ++ " " ++ (show tryThis) ++ " " ++ (show(furCall)))
							wrapFurRed matrix pivot (tryThis+1)
						else --trace ("else " ++ (show pivot))
							furCall
					else --trace "boohoo!"
--						replicate (length(matrix!!0)) 0
						[]
						where furCall = --trace ("furCall " ++ (show matrix) ++ "\nvalidLines " ++ (show (validLines pivot)) ++ "\ntryThis " ++ (show tryThis) ++ "\n" ++ (show( (length(validLines pivot)) > tryThis)))
							furRed matrix ((validLines pivot)!!tryThis) [10..(pivot -1)]
				furRed :: [[Int]] -> [Int] -> [Int] -> [Int]
				furRed []     nxt _			= nxt
				furRed matrix nxt indlst	= if (nxt!!(head indlst)) == 0
					then furRed (drop 1 matrix) nxt (tail indlst)
					else furRed
							(drop 1 matrix)
							(zipWith (-) (map ((*) myLCMnxt) nxt) (map ((*) myLCMmat) (head matrix)))
							(tail indlst)
						where	ind = head indlst
							myLCMnxt = (lcm (nxt!!ind) ((head matrix)!!ind)) `div` (nxt!!ind)
							myLCMmat = (lcm (nxt!!ind) ((head matrix)!!ind)) `div` ((head matrix)!!ind)

filterPermuts :: [([Int],[Int])] -> [String]
filterPermuts splitMat = filter conditions (take 5000000 (permutations ['A'..'J']))
	where
		conditions testStr = if (and (map stage1 splitMat))
			then cond2 testStr
--			then True
			else False
				where
					stage1 (a,_) = case (findIndex (<=(-9)) a) of
						Nothing	-> True
						Just b	-> case elemIndex (['A'..'J']!!b) testStr of
							Nothing -> error ("this letter is not available: " ++ (show b))
							Just c -> c >= 1
		cond2 testStr = if (and (map stage2 splitMat))
			then cond3 testStr
--			then True			
			else False
				where
					stage2 (a,b) =
						(sum (map
							(\(x,y) -> case elemIndex y testStr of
								Nothing -> error ("this letter is not available: " ++ (show y))
								Just z -> (abs x) * z)
							(filter (\(x,_) -> x < 0) (zip a ['A'..'J'])))) >=
						(sum [0..((length (filter (\x -> x>0) (a ++ b)))-1)])
						
		cond3 testStr = if (and (map stage3 splitMat))
			then True
			else False
				where
					stage3 (a,b) =
						(sum (map
							(\(x,y) -> case elemIndex y testStr of
								Nothing -> error ("this letter is not available: " ++ (show y))
								Just z -> (abs x) * z)
							(filter (\(x,_) -> x < 0) (zip a ['A'..'J'])))) <=
						(sum [9..(10-(length (filter (>0) (a ++ b))))])

