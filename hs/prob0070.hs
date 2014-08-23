import Math.NumberTheory.Primes.Factorisation
import Data.Set
import Data.Maybe
import Data.List

sols = Data.Set.map (\n -> ((fromIntegral n) / (fromIntegral (φ n)), n)) perms

perms = Data.Set.filter (\n -> sort(show(φ n)) == sort(show n)) (fromList [2..(10^7-1)])

main = (putStrLn . show) $ fst $ fromJust $ minView sols
