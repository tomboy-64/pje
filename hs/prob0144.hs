import System.IO
import Data.Ratio
import Data.List
import Debug.Trace

main :: IO ()
main = putStrLn ("Solution: " ++ (show (iterator (0%1, 1010%1) (140%1, -960%1) 1)))

iterator start impact counter = if xtrgt <= 1%1 && ytrgt > 0%1
	then counter
	else trace (show counter) iterator impact (impactNew start impact) (counter+1)
		where
			xtrgt = fst(impactNew start impact)
			ytrgt = snd(impactNew start impact)

xVector start end = ((fst end)-(fst start),(snd end)-(snd start))
m point = - ((4*(fst point)) % (snd point))
n point = (- numerator (m point), denominator (m point))

s μ impact = ((fst(impact) + (μ * (fst (n impact)))) , (snd(impact) + (μ * (snd (n impact)))))
f λ impact = ((fst(impact) + (λ * (fst (n impact)))) , (snd(impact) + (λ * (snd (n impact)))))

fs start impact = (((n1) - λ * (x1)),((n2) - λ * (x2)))
	where
		λ = (n1^2 + n2^2) / (x1*n1 + x2*n2)
		n1 = fst (n impact)
		n2 = snd (n impact)
		x1 = fst (xVector start impact)
		x2 = snd (xVector start impact)

p2 start impact = (s 1 impact) `vecAdd` (fs start impact)

xNew start impact = impact `vecSub` (p2 start impact)

impactNew start impact = (((z1) + λ*(x1)),((z2) + λ*(x2)))
	where
		z1 = fst impact
		z2 = snd impact
		x1 = fst (xNew start impact)
		x2 = snd (xNew start impact)
		λ = if l1 /= 0 && l2 == 0
				then l1
			else if l1 == 0 && l2 /= 0
				then l2
			else error ("neither l1 nor l2 are /= 0: " ++ (show l1) ++ " " ++ (show l2))
				where
					l1 = - (2*sqrt(-(x1^2)*(z2^2) + (2*x1*x2*z1*z2) - (x2^2*z1^2) + (250000*x2^2) + (1000000*x1^2)) + (x2*z2) + 4*x1*z1) / ((x2^2) + 4*x1^2)
					l2 = (2*sqrt(-(x1^2)*(z2^2) + (2*x1*x2*z1*z2) - (x2^2*z1^2) + (250000*x2^2) + (1000000*x1^2)) - (x2*z2) - 4*x1*z1) / ((x2^2) + 4*x1^2)

vecAdd (a1,a2) (b1,b2) = (a1+b1, a2+b2)
vecSub (a1,a2) (b1,b2) = (a1-b1, a2-b2)
