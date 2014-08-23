recList x = recList (x ++ [newOne ((fst(last x))+1)])
	where
		newOne y = (y, concat $ map getLowerOnes [1..(y-1)])
			where
				getLowerOnes z = case lookup (y-z) x of
					Nothing -> error ("No such " ++ (show z))
					Just r -> map (\q -> z:q) (filter (\x -> head x <= z) r )
