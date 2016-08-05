pentas = map (\n -> n * (3*n-1) `div` 2) [1..]

p :: Int -> Int
p i = head $ drop (i-1) pentas

isPenta :: Int -> Bool
isPenta i = (head (dropWhile (<i) pentas)) == i

potHits :: [(Int,Int,Int,Int)]
potHits = filter (\(_,_,a,b) -> isPenta a && isPenta b) $ recursor (tail pentas) pentas
    where
        recursor :: [Int] -> [Int] -> [(Int, Int, Int, Int)]
        recursor (a:as) (b:bs)
            | a > b     = (a,b,a+b,a-b) : (recursor (a:as) bs)
            | a <= b    = recursor as pentas
        
main = (putStrLn . show) (head potHits)
