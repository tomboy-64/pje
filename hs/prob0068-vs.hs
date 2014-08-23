import Data.List
permute []      = [[]]
permute list = 
    concatMap (\(x:xs) -> map (x:) (permute xs))
    (take (length list) 
    (unfoldr (\l@(x:xs) -> Just (l, xs ++ [x])) list))
problem_68 = 
    maximum $ map (concatMap show) poel 
    where
    gon68 = [1..10]
    knip = (length gon68) `div` 2
    (is,e:es) = splitAt knip gon68
    extnodes = map (e:) $ permute es
    intnodes = map (\(p:ps) -> zipWith (\ x y -> [x, y])
        (p:ps) (ps++[p])) $ permute is
    poel = [ concat hs |
            uitsteeksels <- extnodes,
            organen <- intnodes,
            let hs = zipWith (:) uitsteeksels organen,
            let subsom = map sum hs,
            length (nub subsom) == 1 ]
