import Data.Char

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

partOfTM :: String -> Bool
partOfTM n = overlapfree n && doubletyOddness n

partOfTM2 :: String -> Bool
partOfTM2 x = doubletyOddness x && subSqTrplChk x && subSqDblChk x && overlapfree x && subSqChk x

-- TMS must be overlapfree, e.g. there exists no WWa with a = head(W)
overlapfree :: String -> Bool
overlapfree n = and (concat (map check [1..(((length n)-1) `div` 2)]))	-- we check from 1-digit long words up to the max of this list
	where
		check m = map check2 [0..((length n)-(m*2+1))]  -- till where is it checked with m digits?
			where
				check2 o = not ((take m (drop o n)) == (take m (drop (o+m) n))
								&& n!!o == n!!(o+2*m))

sqFTcomplete :: String -> Bool
sqFTcomplete n = or [ sqFreeTrans n, sqFreeTrans ('0':n), sqFreeTrans ('1':n) ]

sqFreeTrans :: String -> Bool
sqFreeTrans n = check (take 4 n) (drop 2 n)
	where
		check a b = if (length a) < 4
			then True
			else if ((take 2 a) == (drop 2 a)) || ((a!!0) == (a!!1) && (a!!2) == (a!!3))
				then False
				else check (take 4 b) (drop 2 b)

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

-- the test properties are valid for the Even and the -Odd subsequences as well
subSqChk :: String -> Bool
subSqChk n = checkthem (evens n) (complement (odds n)) || checkthem (complement (evens n)) (odds n)
	where
		checkthem a b = partOfTM a && partOfTM b

subSqDblChk :: String -> Bool
subSqDblChk n = subSqChk (evens n) && subSqChk (odds n)
subSqTrplChk :: String -> Bool
subSqTrplChk n = subSqDblChk (evens n) && subSqDblChk (odds n)

evens :: String -> String
evens n = bla n ""
	where
		bla []		b = b
		bla (_:[])	b = b
		bla (_:a:as)	b = bla as (b ++ [a])
odds :: String -> String
odds (a:as)	= a:(evens as)
odds a		= a

a010060 n = a010060_list !! n
a010060_list :: String
a010060_list = a010060_list_rec "0"
	where
		a010060_list_rec n = n ++ (complement n) ++ a010060_list_rec (n ++ (complement n))

complement :: String -> String
complement z = map (\x -> case x of '0' -> '1'; '1' -> '0') z

a_raw :: Int -> [String]
a_raw n = take n (filter partOfTM2 (map num2bin [1..]))
b_raw :: Int -> [String]
b_raw n = take n (filter (not . partOfTM2) (map num2bin [1..]))

notFoundInSeq test = map (\ x -> (x,bin2num x)) (take 100 (filter (\x -> not $ findSubstring x (take 10000 a010060_list )) (take 100000 (filter test (map num2bin [1..])))))
wronglyFiltered test = map (\ x -> (x,bin2num x)) (take 100 (filter (\x -> findSubstring x (take 10000 a010060_list )) (take 100000 (filter (not . test) (map num2bin [1..])))))

findSubstring :: String -> String -> Bool
findSubstring findThis inThis = or (map check [0..((length inThis)-(length findThis))])
	where
		check ind = take (length findThis) (drop ind inThis) == findThis

main = mapM_ putStrLn (map show (zip3 (a_raw 1100) (map bin2num (a_raw 1100)) [1..]))
