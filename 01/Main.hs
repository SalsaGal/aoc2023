module Main where

import Data.Functor
import Data.Char

solve :: String -> Int
solve = sum . map (read . (\x -> head x : [last x]) . filter isDigit) . lines

main :: IO ()
main = do
  readFile "01/test.txt" >>= print . solve
  readFile "01/input.txt" >>= print . solve
