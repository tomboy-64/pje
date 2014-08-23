powers n = map (\x -> x^n) [1..]
filterIt n = takeWhile (\y -> (length . show) y < n+1) (dropWhile (\y -> (length . show) y < n) (powers n))
main = mapM_ (putStrLn . show) [ length $ concat (map filterIt [1..100])]
