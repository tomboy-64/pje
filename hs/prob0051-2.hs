{-# LANGUAGE MultiWayIf #-}

import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List

multiDigits :: Int -> [Int]
multiDigits x = analyze $ sort $ show x
    where
        analyze :: String -> [Int]
        analyze input
            | count == 0    = []
            | count == 1    = analyze $ drop 1 input
            | otherwise     = (read $ take 1 input) : (analyze $ drop count input)
                where
                    count
                        | input == []  = 0
                        | otherwise = length $ takeWhile (==(head input)) input

myprimes = map fromInteger primes
isMyPrime x = isPrime $ toInteger x
                        
families :: [(Int,[Int],Int)]
families = compute myprimes (multiDigits (head myprimes))
    where
        compute :: [Int] -> [Int] -> [(Int,[Int],Int)]
        compute (_:ps) []   = compute ps (multiDigits (head ps))
        compute px@(p:ps) (d:ds)
            | otherwise     = (minimum lFNP, lFNP, length lFNP) : (compute px ds)
                where
                    lFNP :: [Int]
                    lFNP = filter (\x -> (length $ show x) == (length $ show $ maximum newPrimes)) newPrimes
                    newPrimes :: [Int]
                    newPrimes = filter (isMyPrime) $
                                    replace (head $ show d) p
                    replace :: Char -> Int -> [Int]
                    replace d p = map worker [ 0 .. 9 ]
                        where
                            worker i = read $
                                        map (\x -> if | x == d -> (head $ show i)
                                                      | otherwise -> x)
                                            (show p)

                                                      
main = mapM_ (putStrLn . show) $ filter (\(_,_,x) -> x >= 8) families
