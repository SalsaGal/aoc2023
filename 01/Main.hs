module Main where

import Data.Functor
import Data.Char

solve :: String -> Int
solve = sum . map (read . (\x -> head x : [last x]) . filter isDigit) . lines

main :: IO ()
main = do
  readFile "test.txt" >>= print . solve
  readFile "input.txt" >>= print . solve
