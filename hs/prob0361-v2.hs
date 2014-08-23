import Data.Char
import Data.List

num2bin :: Int -> String
num2bin n
	| n >= 0     =  reverse (n2b n)
	| otherwise  =  error "num2bin: negative number"
		where
			n2b 0  =  ""
			n2b n  =  intToDigit(n `mod` 2) : n2b (n `div` 2)

bin2num :: String -> Int
bin2num n = rep 0 n
	where
		rep acc [] = acc
		rep acc (n:ns) = rep ((2*acc) + (digitToInt n)) ns

-- TMS must be overlapfree, e.g. there exists no WWa with a = head(W)
overlapfree :: String -> Bool
overlapfree n = and (concat (map check [1..(((length n)-1) `div` 2)]))	-- we check from 1-digit long words up to the max of this list
	where
		check m = map check2 [0..((length n)-(m*2+1))]  -- till where is it checked with m digits?
			where
				check2 o = not ((take m (drop o n)) == (take m (drop (o+m) n))
								&& n!!o == n!!(o+2*m))

-- If s_j = s_j+1 then j must be odd.
doubletyOddness :: String -> Bool
doubletyOddness n = check (-1) 0
	where
		check indicator idx = if length n > (idx+1)
								then if (n!!idx) == (n!!(idx+1))
									then if indicator >= 0
										then if (even indicator) /= (even idx)
											then False
											else check indicator (idx+2)
										else check idx (idx+2)
									else check indicator (idx+1)
								else True

evens :: String -> String
evens n = bla n ""
	where
		bla []		b = b
		bla (_:[])	b = b
		bla (_:a:as)	b = bla as (b ++ [a])
odds :: String -> String
odds (a:as)	= a:(evens as)
odds a		= a

complement :: String -> String
complement z = map (\x -> case x of '0' -> '1'; '1' -> '0') z

{- for tests -}

a010060 n = a010060_list !! n
a010060_list :: String
a010060_list = a010060_list_rec "0"
    where
	        a010060_list_rec n = n ++ (complement n) ++ a010060_list_rec (n ++ (complement n))

findSubstring :: String -> String -> Bool
findSubstring findThis inThis = or (map check [0..((length inThis)-(length findThis))])
	where
		check ind = take (length findThis) (drop ind inThis) == findThis

notFoundInSeq = map
					(\ x -> (x,bin2num x))
					(take 100
						(filter (\x -> not $ findSubstring x (take 10000 a010060_list ))
							(take 100000 (realList))))
wronglyFiltered = map
					(\ x -> (x,num2bin x))
					(take 100
						(filter (\x -> findSubstring (num2bin x) (take 10000 a010060_list ))
							(take 100000
								(filter (\x -> x /= last(takeWhile (<= x) (map bin2num realList)))
									[1..]))))

{- tests end -}

a_raw :: Int -> [String]
a_raw n = take n $ concat assembleList

realList = (filter (\x -> (head x) /= '0') (concat assembleList))

assembleList = map assembleThem [0..]

assembleThem 0 = ["0","1"]
assembleThem n = sortBy myOrd
					( filter (\ x -> doubletyOddness x && overlapfree x)
					( assemble n ))
			where
				assemble x	= if odd x -- assembleThem works on list indices, which start with 0.
								then squarify
										(assembleList!!(x `div` 2))
										(map complement (assembleList!!(x `div` 2)))
								else squarifyx
										(assembleList!!((x `div` 2)))
										(map complement(assembleList!!((x `div` 2)-1)))
				cczW a b	= concat( zipWith (\x y -> [x,y]) a b )
				myOrd a b 	= if (bin2num a) > (bin2num b)
								then GT
								else if (bin2num a) < (bin2num b)
									then LT
									else EQ
				squarify a b	= concat( map (\x -> map (\y -> cczW x y) b) a )
				squarifyx a b	= map init (squarify
												a
												(map (\ x -> x ++ ['x']) b))

--main = mapM_ putStrLn (map show (zip3 (a_raw 1100) (map bin2num (a_raw 1100)) [1..]))
--main = putStrLn $ show $ length $ takeWhile (\(_,x) -> x <= 80852364498) notFoundInSeq
--main = mapM_ (\x -> putStrLn $ show x) $ scanl1 (+) $ map (\x -> bin2num $ realList!!(10^x)) [1..18]
main = mapM_ (\x -> putStrLn $ show x) $ takeWhile (\(_,x) -> x <= 80852364498) notFoundInSeq
