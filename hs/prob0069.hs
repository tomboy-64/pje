import Math.NumberTheory.Primes.Factorisation
import Data.Set
import Data.Maybe

sols = Data.Set.map (\n -> ((fromIntegral n) / (fromIntegral (φ n)), n)) (fromList [1..10000000])

main = (putStrLn . show) $ fst $ fromJust $ maxView sols
