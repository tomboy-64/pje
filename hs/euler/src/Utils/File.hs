-----------------------------------------------------------------------------
--
-- Module      :  Utils.File
-- Copyright   :
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Utils.File (

) where

parseFile :: String -> String

parseCsvStrings :: String -> [String]

parseCsvInts :: String -> [Int]

readit :: String -> String
readit input = do
  inh <- openFile input ReadMode
  inpStr <- hGetContents inh
  hClose inh
  inpStr

