import Math.NumberTheory.Powers.Squares
import Data.List
import Debug.Trace


e x a c
  = ( res, a', d)
    where
      d = (x - a*a) `div` c
      res = (integerSquareRoot x + a) `div` d
      a' = (res * d) - a

check (x,a,c,list)
  | length list /= 2
    && p == q
    && init == [a,c]  = (x, length p, p)
  | otherwise = check (x,n,o,(m:list))
    where
      l = take ((length list) -2) list
      (p,q) = splitAt ((length l) `div` 2) l
      (m,n,o) = e x a c
      init = drop ((length list) -2) list


evalList = filter (not . isSquare) [1..10000]

main = (putStrLn . show)
        $ length
        $ filter (\(_,a,_) -> odd a)
        $ map check (map (\n -> (n,integerSquareRoot n,1,[integerSquareRoot n,1])) evalList)
