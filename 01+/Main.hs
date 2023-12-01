module Main where
import Data.List
import Data.Maybe
import Control.Applicative

numbers :: [String]
numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  ++ [show x | x <- [1..9]]

getPrefix :: String -> String -> Maybe String
getPrefix xs ys
  | xs `isPrefixOf` ys = Just xs
  | otherwise = Nothing

firstNumber :: (String -> String -> Maybe String) -> String -> String
firstNumber f xs = fromMaybe (firstNumber f (tail xs)) $ listToMaybe (mapMaybe (`f` xs) numbers)

main :: IO ()
main = do
  readFile "test.txt" >>= print . map (firstNumber getPrefix) . lines
