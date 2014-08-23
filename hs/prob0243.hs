import Data.Ratio
import Math.NumberTheory.Primes
import Debug.Trace

target = 15499 % 94744

mySieve = totientSieve 10000000

main = mapM_ (putStrLn.show)
			$ ( scanl mainloop (0,1%1,1.0) (repeat 2) )

mainloop (a,mini,_) b = if tott < 15499 % 94744
	then error ((show a) ++ " " ++ (show tott))
	else if tott < mini
		then (a+10, tott, fromRational tott)
		else
--			trace ((show (a+2)) ++ " " ++ (show mini) ++ " " ++ (show tott))
			mainloop (a+10,mini,1.0) 0
			where
				tott = (totient (a+10)) % (a+9)

