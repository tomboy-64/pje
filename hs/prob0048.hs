result = scanl1 (\x y -> (x + (y^y)) `rem` 10000000000) [1..1000]

main = mapM_ (putStrLn . show) result
