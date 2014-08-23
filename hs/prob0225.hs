trib = (map zed [0 ..] !!)
	where zed 0 = 1
	      zed 1 = 1
	      zed 2 = 1
	      zed n = trib (n-3) + trib (n-2) + trib (n-1)

invmod a b = if a `mod` b == 0 then False else True

--check z = take 30 $ drop 123 $ filter (\x -> and $ map (\y -> y `invmod` x) (divisables (z*1000))) [3,5..]
check n z = take n $ filter (\x -> and $ map (\y -> y `invmod` x) (take z a000213_list)) [21,23 ..]

a000213 n = a000213_list !! n
a000213_list = 1 : 1 : 1 : zipWith (+) a000213_list (tail $ zipWith (+) a000213_list (tail a000213_list)) 

--main = print $ trib 10000
--main = print $ map check [1..100]
