import Data.Ratio

recFrac = scanl fracThis (3%2) [1..]

fracThis x _ = 1 + (1 / (2 + (x-(1%1))))

myFilter x = (length $ show $ numerator x) > (length $ show $ denominator x)

main = (putStrLn . show) $ length (filter myFilter (take 1000 recFrac))
