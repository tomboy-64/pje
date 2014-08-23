--import Debug.Trace
import Math.NumberTheory.Primes.Testing

boolRow x = map isPrime $ plainRow x
filterRow x = filter isPrime $ plainRow x

frst (a,_,_) = a
scnd (_,a,_) = a
thrd (_,_,a) = a

plainRow x = [ z .. z+x-1 ]
	where z = sum([1..x-1]) + 1

sparseRow a = map (\x -> if (isPrime x) then x else 0) (plainRow a)

makeEnvStruct a = map sparseRow [ a-2 .. a+2 ]

paddedEnvStruct a = [ ([0,0] ++ (sparseRow (a-2)) ++ [0,0,0,0])
			, ([0] ++ (sparseRow (a-1)) ++ [0,0])
			, (sparseRow a)
			, ([0] ++ (sparseRow (a+1)))
			, ([0,0] ++ (sparseRow (a+2))) ]

makeSemiFinalStruct a = tier1 ((paddedEnvStruct a) !! 2) ((paddedEnvStruct a) !! 1) ((paddedEnvStruct a) !! 3)
	where	tier1 []     _          _          = []
		tier1 (x:xs) (a:b:c:ys) (d:e:f:zs) = if x == 0
						then (x, [], []):tier1 xs (b:c:ys) (e:f:zs)
						else (x, [a,b,c], [d,e,f]):tier1 xs (b:c:ys) (e:f:zs)

makeFinalStruct a = tier2 (makeSemiFinalStruct a) ((paddedEnvStruct a) !! 0) ([0,0] ++ ((paddedEnvStruct a) !! 2) ++ [0,0]) ((paddedEnvStruct a) !! 4)
	where	tier2 []     _              _              _              = []
		tier2 (i:as) (b:c:d:e:f:hs) (n:o:p:q:r:ss) (u:v:w:x:y:zs) =
			if (frst i) == 0
			then (frst i, False):tier2 as (c:d:e:f:hs) (o:p:q:r:ss) (v:w:x:y:zs)
			else (frst i,
				or [
					and [ sum (scnd i) > 0, sum (thrd i) > 0 ],
					and [ ((scnd i) !! 0) > 0, ((scnd i) !! 2) > 0 ],
					and [ ((thrd i) !! 0) > 0, ((thrd i) !! 2) > 0 ],
					and [ ((scnd i) !! 0) > 0,
						or [ b>0, c>0, d>0, n>0 ] ],
					and [ ((scnd i) !! 1) > 0,
						or [ c>0, d>0, e>0 ] ],
					and [ ((scnd i) !! 2) > 0,
						or [ d>0, e>0, f>0, r>0 ] ],
					and [ ((thrd i) !! 0) > 0,
						or [ u>0, v>0, w>0, n>0 ] ],
					and [ ((thrd i) !! 1) > 0,
						or [ v>0, w>0, x>0 ] ],
					and [ ((thrd i) !! 2) > 0,
						or [ w>0, x>0, y>0, r>0 ] ]
				]):tier2 as (c:d:e:f:hs) (o:p:q:r:ss) (v:w:x:y:zs)
--		tier2 aOne aTwo aThree aFour = trace (show aOne ++ show aTwo ++ show aThree ++ show aFour ) (error "went through to the non-exhaustive bit")


extTup (x, n) b = if b
	then filter isPrime [ z | z <- [ x-n .. x-n+2], z > sum [1..n-2], z <= sum [1..n-1]]
	else filter isPrime [ z | z <- [ x+n-1 .. x+n+1], z > sum [1..n], z <= sum [1..n+1]]

getTrianglesOfRow x = map (\(a,b) -> a) (filter (\(a,b) -> b ) (makeFinalStruct x))
s x = sum $ getTrianglesOfRow x

fallthroughs x = filter (\a -> not $ elem a (getTrianglesOfRow x)) (map frst (filter (\(a,b,c) -> sum (b ++ c) > 0) (makeSemiFinalStruct x)))
verbEnv x = filter (\a -> length a > 2) $ map (\a -> concat $ map (\a -> filter isPrime a) 
				[[(a-x-x+1) .. (a-x-x+5)],
				[(a-x-1) .. (a-x+3)],
				[(a-2) .. (a+2)],
				[(a+x-2) .. (a+x+2)],
				[(a+x+x-1) .. (a+x+x+3)]]
			) (fallthroughs x)

test = s 10000
a = s 5678027
b = s 7208785

--main = verbEnv 10000

main = do	putStrLn ("Test:           " ++ show test)
--		putStrLn ("partial 10:     " ++ show (take 10 (getTrianglesOfRow 5678027)))
--		putStrLn ("partial 500:    " ++ show (length (getTrianglesOfRow 7208785)))
		putStrLn ("100000:         " ++ show (s 100000))
		putStrLn ("200010:         " ++ show (s 200010))
		putStrLn ("150073:         " ++ show (s 150073))
--		putStrLn ("Sum [1..10000]: " ++ (show $ sum $ map s [1..10000]))
		putStrLn ("S( 5678027 ):   " ++ show a)
		putStrLn ("S( 7208785 ):   " ++ show b)
		putStrLn ("Result:       " ++ show (a+b))
