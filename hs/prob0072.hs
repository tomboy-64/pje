import Data.Set
import Data.Ratio
import Debug.Trace

nextSet d = fromList(Prelude.map (\x -> x%d) [1..(d-1)])

allItems d = foldl1 (\a b -> union a b) (Prelude.map nextSet [1..d])

main = (putStrLn . show) $ size $ allItems 10000
