module Main where

import           Data.Char
import           Data.Functor

solve :: String -> Int
solve = sum . map (read . (\x -> head x : [last x]) . filter isDigit) . lines

main :: IO ()
main = do
  readFile "test.txt" >>= print . solve
  readFile "input.txt" >>= print . solve
