import Math.NumberTheory.Primes.Factorisation
import Data.IntMap.Lazy

incrementor []		  myMap acc =
incrementor (p:rImes) myMap acc =
	case lookup newPhi myMap of
		Nothing -> incrementor (p:rImes) (backtrack newPhi myMap []) acc
		Just (-1) -> incrementor rImes (insert (p-1) (-1) myMap) acc
		Just 23 -> incrementor rImes (insert (p-1) newPhi myMap) (acc+p)
		Just x  -> if x < 23
					then incrementor rImes (insert (p-1) (x+1) myMap) acc
					else incrementor rImes (insert (p-1) (-1) myMap) acc
			where
				newPhi = φ (p-1)
				backtrack :: Int -> IntMap Int -> [Int] -> IntMap Int
				backtrack newItem myMap []    = 
				backtrack newItem myMap (b:t) = case lookup newItem myMap of
									Nothing -> insert 


singleton 1 1

