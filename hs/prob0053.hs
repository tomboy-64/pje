import Data.List
import Data.Maybe

nCr :: Int -> Int -> Maybe Int
nCr r n = if r>n
		then Nothing
		else if (fac !! n) `div` ((fac !! r) * (fac !! (n-r))) > 1000000
			then Just 1
			else Nothing

fac = map fac' [0..]
	where
		fac' 0 = 1
		fac' x = x * (fac' (x-1))

main = putStrLn $ show $ length $ catMaybes [ nCr r n | r <- [1..100], n <- [1..100], r <= n ]
