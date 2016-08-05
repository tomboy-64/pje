import Math.NumberTheory.Primes.Sieve
import Math.NumberTheory.Primes.Testing
import Data.List

isPd :: Integer -> Bool
isPd input = swallow 1 $ sort $ show input
    where
        swallow :: Int -> String -> Bool
        swallow _ []    = True
        swallow i rest  = ((show i) == (take 1 rest)) && (swallow (i+1) (drop 1 rest))

main = mapM_ (putStrLn . show) $ filter isPd (takeWhile (<= 987654321) primes)
