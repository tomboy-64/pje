import Data.List

s = [ x^2 | x <- [1..100] ]
u (x,y) = filter (\z -> length z == y) $ subsequences x

main = sum $ u (s,50)
