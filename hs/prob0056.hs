import Data.Char
import Data.List

googolize :: [String]
googolize = concat $ map gg2 [1..99]
	where
		gg2 a = map gg3 [1..99]
			where
				gg3 b = show (a^b)

main = mapM_ (putStrLn . show) $ (map normalize googolize) ++ [ last $ sort $ map normalize googolize ]
	where
		normalize :: String -> Int
		normalize x = norm x 0
			where
				norm :: String -> Int -> Int
				norm [] acc		= acc
				norm (x:xs) acc = norm xs (acc + (digitToInt x))
