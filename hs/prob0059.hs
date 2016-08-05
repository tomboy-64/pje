import System.IO
import Data.Bits
import Data.Char
import Data.List
import Debug.Trace

main :: IO ()
main = do 
    inh <- openFile "cipher1.txt" ReadMode
    inpStr <- hGetContents inh
    let ciphertext = processData inpStr
    let crack = processCrack ciphertext [ [a,b,c] | a<-[97..122], b<-[97..122], c<-[97..122] ] []
--    (putStrLn.show) (length ciphertext)
    (putStrLn.show) crack
--    (putStrLn.show.length) matrix
    hClose inh

processData :: String -> [Int]
processData input = read ("["++input++"]")

processCrack :: [Int] -> [[Int]] -> [String] -> Int
--processCrack ciphertext [] acc = acc
processCrack ciphertext passwords acc = if match
                            then sum decrypted
                            else
                                trace (show decrypted)
                                processCrack ciphertext (drop 1 passwords) acc
    where
--        match = or $ map (\x -> elem x (words decrypted)) testWords
        match = map chr (take (length testWords)  decrypted) == testWords
        decrypted = zipWith xor (concat (repeat (head passwords))) ciphertext

testWords = "(The Gospel of John, chapter 1"
analyze ciphertext = filter (\x -> snd x /= 0) $ map (\x -> (x, length (elemIndices x ciphertext))) [1..(maximum ciphertext)]
