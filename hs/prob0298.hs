import System.Random
import Data.List
import Data.Ratio
  
main = do  
    gen <- getStdGen  
    mainLoop (0,0%1) (randomRs (1,10) gen)

{-
askForNumber :: StdGen -> IO ()  
askForNumber gen = do  
    let (randNumber, newGen) = randomR (1,10) gen :: (Int, StdGen)  
    putStr "Which number in the range from 1 to 10 am I thinking of? "  
    numberString <- getLine  
    when (not $ null numberString) $ do  
        let number = read numberString  
        if randNumber == number   
            then putStrLn "You are correct!"  
            else putStrLn $ "Sorry, it was " ++ show randNumber  
        askForNumber newGen
-}
mainLoop :: (Integer,Ratio Integer) -> [Int] -> IO ()
mainLoop (round,ratio) rands = do
	let result = game (take 50 rands)
	let newResult = (((fromIntegral round) * ratio) + (fromIntegral result)) * (1%(round+1))
--	if (round `rem` 10000) then
	putStr ("\r" ++ (show round) ++ " " ++ (show (fromRational(newResult) )))
	mainLoop (round+1,newResult) (drop 50 rands)

game :: [Int] -> Int
game initRand = round initRand 0 [] 0 []
	where
		round :: [Int] -> Int -> [Int] -> Int -> [Int] -> Int
		round [] lScore _ rScore _ = lScore-rScore
		round (rand:remRands) lScore lMem rScore rMem =
			round remRands newLScore newLMem newRScore newRMem
				where
					newLScore = if rand `elem` lMem
							then lScore + 1
							else lScore
					newLMem = if length lMem <5
							then rand:lMem
							else if rand `elem` lMem
								then rand:(delete rand lMem)
								else rand:(init lMem)
					newRScore = if rand `elem` rMem
							then rScore + 1
							else rScore
					newRMem = if length lMem < 5
							then rand:lMem
							else rand:(init rMem)

