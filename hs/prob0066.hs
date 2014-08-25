-- Created by tomboy64 on 25-8-14
-- Solving Project Euler Problem #66
-- This attempt uses work done on #64, e.g. solving Pell's Equation via fractional development of square roots



import Math.NumberTheory.Powers.Squares
import Data.List
import Debug.Trace

-- Here we start iterating, checking at every round whether a iteration was determined
check :: (Int,Int,Int,[Int]) -> (Int,[Int])
check (x,a,c,list)
  | length list /= 2
    && p == q
    && init == [a,c]  = (x, p ++ [integerSquareRoot x])
  | otherwise = check (x,n,o,(m:list))
    where
      l = take ((length list) -2) list
      (p,q) = splitAt ((length l) `div` 2) l
      (m,n,o) = e x a c
      init = drop ((length list) -2) list
-- This is the worker to determine the next fraction to add
      e :: Int -> Int -> Int -> (Int,Int,Int)
      e x a c = ( res, a', d)
        where
          d = (x - a*a) `div` c
          res = (integerSquareRoot x + a) `div` d
          a' = (res * d) - a

fracDev = map check (map (\n -> (n,integerSquareRoot n,1,[integerSquareRoot n,1])) evalList)
	where
		evalList :: [Int]
		evalList = filter (not . isSquare) [1..1000]

processor :: (Int,[Int]) -> (Int,Integer)
processor (a,b) = (a, head
					$ dropWhile (== 0)
					$ map (\n -> diophEquation n (toInteger a))
					$ fracList
					$ transformFracDev (a,b))
	where
		diophEquation :: (Integer,Integer) -> Integer -> Integer
		diophEquation (x,y) d
			| x^2 - d * y^2 == 1	= x
			| otherwise				= 0
		transformFracDev :: (a,[Int]) -> [Int]
		transformFracDev (_,xs) = sx ++ (concat $ repeat $ tail sx)
			where
				sx = reverse xs
		fracList :: [Int] -> [(Integer,Integer)]
		fracList ys = map (\n -> tupleProducer (take n (map toInteger ys)) (0,1)) [1..]
			where
				tupleProducer xs (a,b)
					| xs == []	= (b,a)
					| otherwise = tupleProducer (init xs) (b,(last xs)*b + a)

compIt (_,a) (_,b)
	| a > b = GT
	| a < b = LT
	| a == b = EQ

main = mapM_ (putStrLn . show)
		$ sortBy compIt
		$ map processor fracDev

