import System.IO
import Data.Char
import Data.List
import Debug.Trace

main :: IO ()
main = do 
       inh <- openFile "words.txt" ReadMode
       mainloop inh 
       hClose inh

mainloop :: Handle -> IO ()
mainloop inh = 
    do ineof <- hIsEOF inh
       if ineof
           then return ()
           else do inpStr <- hGetLine inh
--                   mapM_ (\x -> putStrLn(show x)) (parse inpStr)
                   putStrLn (show(parse inpStr))
                   putStrLn("")
                   mainloop inh

triangles = map (\x -> ((x * (x+1))`div`2)) [1..]
isTriangle :: Int -> Bool
isTriangle n = if (head (dropWhile (<n) triangles)) == n
				then True
				else False

wordSum x = wS x 0
	where
		wS [] acc = isTriangle acc
		wS (x:xs) acc = case (elemIndex x "_ABCDEFGHIJKLMNOPQRSTUVWXYZ") of
						Nothing -> error "what word is this?"
						Just y -> wS xs (acc+y)

parse inpStr = length $ filter wordSum (read ("[" ++ inpStr ++ "]"))
