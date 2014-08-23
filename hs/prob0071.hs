import Data.Ratio
import Data.List

--oneList d = (last $ (takeWhile (\x -> x%d < 3%7) [1..])) % d
newMember d = ((3*d)-1) % (7*d)

listOfFracs = takeWhile (\x -> denominator x <= 1000000) $ map newMember [3..]

main = mapM_ (putStrLn . show) (listOfFracs ++ [maximum listOfFracs])
