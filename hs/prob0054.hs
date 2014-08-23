import System.IO
import Data.Char
import Data.List
import Debug.Trace

main :: IO ()
main = do 
       inh <- openFile "poker.txt" ReadMode
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
                   error "just a test"
                   putStrLn("")
                   mainloop inh

-- first we parse shit
parse inpStr = [ (hand (take 14 inpStr)), (hand (drop 15 inpStr)) ]

hand x = map (\y -> (x!!y,x!!(y+1))) [0,3..12]


-- x = [(val,suit),(val,suit),(val,suit),(val,suit),(val,suit)]
isStraightFlush x	= isStraight x && isFlush x
isFourOfAKind x		= length(findIndices (\(val1,_) -> val1 == fst(x!!0)) x) == 4 ||
						length(findIndices (\(val1,_) -> val1 == fst(x!!1)) x) == 4
isFullHouse x		= isPair x && isTriple x
isFlush x			= length(findIndices(\(_,val2) -> val2 == snd(x!!0)) x) == 5
isStraight x		= and [	vals!!1 == (vals!!0)+1
						   ,vals!!2 == (vals!!1)+1
						   ,vals!!3 == (vals!!2)+1
						   ,or [ vals!!4 == (vals!!3)+1
								,vals!!4 == 14 && vals!!0 == 2 ]]
	where
		vals = sort $ map (\(y,_) -> conv2numval y) x
isTriple x			= or $ map (\y -> length(findIndices (\(val1,_) -> val1 == fst(x!!y)) x) == 3) [0..2]
isTwoPair x			= (length $ findIndices (=='2') $ map (\y -> length(findIndices (\(val1,_) -> val1 == fst(x!!y)) x) == 3) [0..4]) == 4
isPair x			= (length $ findIndices (=='2') $ map (\y -> length(findIndices (\(val1,_) -> val1 == fst(x!!y)) x) == 3) [0..4]) == 2
isHighCard x		= not $ or [ isPair x, isTwoPair x, isTriple x, isStraight x, isFlush x, isFullHouse x, isFourOfAKind x, isStraightFlush x ]

pO x y = pO' (conv2numval x) (conv2numval y)
	where
		pO' a b			= if a > b then GT
						else if a < b then LT
						else if a == b then EQ
						else error "eh wat"

conv2numval z = if z == '2' then 2
				else if z == '3' then 3
				else if z == '4' then 4
				else if z == '5' then 5
				else if z == '6' then 6
				else if z == '7' then 7
				else if z == '8' then 8
				else if z == '9' then 9
				else if z == 'T' then 10
				else if z == 'J' then 11
				else if z == 'Q' then 12
				else if z == 'K' then 13
				else if z == 'A' then 14
				else error ("not a valid card" ++ (show z))
