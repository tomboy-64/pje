import Data.Maybe
import Data.Char



main = mapM_ putStrLn jingleBells

jingleBells :: [String]
jingleBells = catMaybes $ map checker [2..200000] ++ [ Just $ show $ sum $ map read $ catMaybes $ map checker [2..200000] ]

checker :: Int -> Maybe String
checker x = checkRec (show x) 0
	where
		checkRec :: String -> Int -> Maybe String
		checkRec [] acc 	= if acc == x
								then Just (show x)
								else Nothing
		checkRec (a:as) acc	= if ((digitToInt a)^5) + acc <= x
								then checkRec as (acc + ((digitToInt a)^5))
								else Nothing
