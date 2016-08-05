chConst :: String
chConst = rest 1
    where
        rest :: Int -> String
        rest x = (show x) ++ (rest (x+1))

d :: Int -> String -> Char
d x input = head $ drop (x-1) input

result :: Int -> [Int]
result maxi = map read $ wrkr 0
    where
        wrkr :: Int -> [String]
        wrkr i
            | i < maxi  = (take 1 (drop (10^i-1) chConst)) : (wrkr (i+1))
            | i == maxi = [take 1 (drop (10^i-1) chConst)]


main = do
    mapM_ (putStrLn . show) $ result 6
    putStrLn "==="
    putStrLn $ show $ product $ result 6
