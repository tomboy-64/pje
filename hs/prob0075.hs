import Math.NumberTheory.Powers
import Data.List

maxi = 1500000

triangles = [ (a,b) | a <- [1..(maxi `div` 2)]
					, b <- [a..(maxi `div` 2)]
					, isSquare (a^2+b^2) ]

completeTriangles = map (\(a,b) -> (a,b,integerSquareRoot(a^2+b^2))) triangles
triSums = map (\(a,b,c) -> a+b+c) completeTriangles

total = takeWhile (<maxi+1) (sort triSums)

--main = (putStrLn . show) (length total)
main = mapM_ (putStrLn . show) triSums
