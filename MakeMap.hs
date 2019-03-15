-- Make map.json from data.csv
-- Usage: stack runhaskell --package split --package multimap -- MakeMap.hs < data.csv > map.json

{-# OPTIONS_GHC -Wall -Werror #-}

import Data.List (intercalate)
import Data.List.Split (splitOn)
import Data.MultiMap (MultiMap)
import qualified Data.MultiMap as MM (assocs, empty, insert)
import System.IO

insertOne :: Int -> MultiMap Char Int -> Char -> MultiMap Char Int
insertOne ch m v = MM.insert v ch m

getMap :: MultiMap Char Int -> String -> MultiMap Char Int
getMap m x = let [colA,_,colC] = splitOn "," x in foldl (insertOne $ read colA) m colC

pp :: (Char, [Int]) -> String
pp (k,v) = '"' : k : "\":\"" <> (intercalate " " $ fmap show v) <> "\""

solve :: String -> String
solve str =
 let contents = lines str
  in intercalate ",\n" $ fmap pp $ MM.assocs $ foldl getMap MM.empty contents

main :: IO ()
main = do
  putStr "{\n"
  putStr . solve =<< getContents
  putStr "\n}"
