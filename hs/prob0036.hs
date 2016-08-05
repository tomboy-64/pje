testees = [ 1 .. 999999 ]

convertToBinary :: Int -> String
convertToBinary x
    | x == 1            = "1"
    | x `mod` 2 == 1    = (convertToBinary (x `div` 2)) ++ "1"
    | x `mod` 2 == 0    = (convertToBinary (x `div` 2)) ++ "0"
    | otherwise         = error "something went wrong here"
            
isPalindrome :: String -> Bool
isPalindrome x
    | (head x) == '0'   = error ((show x) ++ " has a leading zero")
    | otherwise         = ip x
    where
        ip :: String -> Bool
        ip x
            | (length x) <= 1       = True
            | (head x) == (last x)  = ip $ tail $ init x
            | otherwise             = False

checkNum :: Int -> Bool
checkNum x =
    and [
          isPalindrome $ show x
        , isPalindrome $ convertToBinary x ]

result = filter checkNum testees

main = do
    mapM_ (putStrLn . show) $ result
    putStrLn "==="
    putStrLn $ show $ sum $ result
