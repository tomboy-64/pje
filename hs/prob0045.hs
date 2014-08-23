import Data.List

hexagonal :: [Integer]
hexagonal 	= map (\n -> n*((2*n)-1)) [1..]
pentagonal :: [Integer]
pentagonal 	= map (\n -> (n*((3*n)-1)) `div` 2) [1..]
triangle :: [Integer]
triangle 	= map (\n -> (n*(n+1)) `div` 2) [1..]

isOrd :: [Integer] -> [Integer] -> [Integer] -> [Integer]
isOrd aa@(a:as) bb@(b:bs) cc@(c:cs)
	| a > b		&& b > c	= isOrd aa bb cs
	| a > b		&& b == c	= isOrd aa bs cs
	| a > b		&& b < c	= isOrd aa bs cc
	| a == b	&& b > c	= isOrd aa bb cs
	| a == b	&& b == c	= [ a ] ++ (isOrd as bs cs)
	| a == b	&& b < c	= isOrd as bs cc
	| a < b		&& a > c	= isOrd aa bb cs
	| a < b		&& a == c	= isOrd as bb cs
	| a < b		&& a < c	= isOrd as bb cc

main = mapM_ (putStrLn . show) (isOrd hexagonal pentagonal triangle)
