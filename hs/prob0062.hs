import Math.NumberTheory.Powers
import Data.Maybe
import Data.List
import qualified Data.Set as S
import Debug.Trace

cubes :: [(Int,Int,String)]
cubes = map (\ x -> (x,x^3,sort $ show (x^3))) [1..]

sortCubes (_,_,x) (_,_,y) = if        x > y then    GT
                            else if    x < y then    LT
                            else                EQ

episode :: Int -> [(Int, Int, String)]
episode x = filter (\ (_,_,a:_) -> a /= '0')
--            $ sortBy sortCubes
            $ takeWhile (\ (_,y,_) -> y < 10^x)
            $ dropWhile (\ (_,y,_) -> y < 10^(x-1)) cubes

results = map (\x -> myFilter x []) (map episode [1..]) 
    where
--        myFilter :: [(Int,Int,String)] -> Int -> [String] -> [String]
--        myFilter (_:[]) ctr acc        = (myInit acc) ++ [(myLast acc) ++ " " ++ (show ctr)]
{-        myFilter (a:bs) ctr acc = if ctr == 0
                                then if thrd a == (thrd $ head bs)
                                    then myFilter bs (ctr+1) (acc ++ [(show a)])
                                    else myFilter bs 0 acc
                                else if ctr == 4
                                    then error ( (show a) ++ " " ++ (show ctr))
                                else if thrd a == (thrd $ head bs)
                                    then trace ("dbg: " ++ (show a)) myFilter bs (ctr+1) acc
                                    else trace ("dbg: " ++ (show a) ++ " " ++ (show ctr)) myFilter bs 0 ((myInit acc) ++ [(myLast acc) ++ " " ++ (show ctr)])-}
        myFilter (_:[]) acc = acc
        myFilter (a:bs) acc = if length bla >= 3
                                then myFilter bs (acc ++ [((length bla)+1, frst a, scnd a)])
                                else myFilter bs acc
            where
                bla = findIndices (\(_,_,x) -> x == thrd a) bs

main = mapM_ (putStrLn . show) $ results

frst (a,_,_) = a
scnd (_,a,_) = a
thrd (_,_,a) = a
myInit x = take ((length x)-2) x
myLast [] = ['x']
myLast x = last x
