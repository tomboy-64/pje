import Math.NumberTheory.Primes.Factorisation
import Data.List

main = mapM_ (putStrLn . show) checker

checker :: [Integer]
checker = chk 3
	where
		chk :: Integer -> [Integer]
		chk d = if lfd == 4
					then if lfc == 4
						then if lfb == 4
							then if lfa == 4
								then if mangle pfc == []
									then if mangle pfb == []
										then if mangle pfa == []
											then [(d-3)]
											else [fromInteger d] ++ (chk (d+1))
										else chk (d+2)
									else chk (d+3)
								else chk (d+1)
							else chk (d+2)
						else chk (d+3)
					else chk (d+4)
			where
				a = d-3
				fa = factorise' $ fromInteger a
				lfa = length fa
				pfa = fa ++ pfb
				b = d-2
				fb = factorise' $ fromInteger b
				lfb = length fb
				pfb = fb ++ pfc
				c = d-1
				fc = factorise' $ fromInteger c
				lfc = length fc
				pfc = fc ++ fd

				fd = factorise' $ fromInteger d
				lfd = length fd
				ex xs = map fromInteger $ map (\(a,b) -> a) xs 
				mangle x = filter (\y -> length y > 1) $ group $ sort $ x


