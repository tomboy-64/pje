import Math.NumberTheory.Primes.Factorisation

--zeta = zipWith (*) (repeat 510510) [1..10^6]
--zeta2 = sum $ map φ zeta
m = 510510
n = 10^6

d = gcd m n
delta x = (φ x) * d `div` (φ d)
zeta = (φ m) * d `div` (φ d)
zeta2 = sum (map delta [1..n])
main = print (show (zeta2 * zeta))


-- φ(mn) = φ(m) * φ(n) * d/φ(d)
