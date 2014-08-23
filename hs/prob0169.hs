fusc' 0 = (1,0)
fusc' n
    |even n = (a+b, b)
    |odd n = (a,a+b)
    where
        (a,b) = fusc' $n`div`2
fusc = fst.fusc'
main = fusc (10^25)
