import Math.NumberTheory.Powers.Squares
import Data.List

tuples = [ a+b+(integerSquareRoot'(a^2 + b^2)) | a <- [1..1000],
					b <- [1..1000],
					a <= b,
					isSquare'(a^2+b^2),
					(integerSquareRoot'(a^2 + b^2))+a+b <= 1000 ]

filterTuples = fT tuples (replicate 1001 0)
	where
		fT [] list		= zip (map (\x -> elemIndex x list) [1..30]) [1..]
		fT (t:ts) list	= fT ts (addUp t list)
			where
				addUp t list = (take t list) ++ [(list!!t) + 1] ++ (drop (t+1) list)

main = mapM_ (putStrLn . show) $ filterTuples
