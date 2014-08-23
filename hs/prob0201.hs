import Data.List
import Debug.Trace

s :: [Int]
s = [ x^2 | x <- [1..100] ]
u (x,y) = map sum $ filter (\z -> length z == y) $ subsequences x

rec [] unique _ = sum unique
rec (a:rest) unique multiple =
	if a `elem` unique
		then
			trace (show a)
			rec rest (delete a unique) (a:multiple)
	else if a `elem` multiple
		then
			trace (show a)
			rec rest unique multiple
	else rec rest (a:unique) multiple

main = (putStrLn . show) (rec (u (s,50)) [] [])
