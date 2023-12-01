module Main where
import Data.List
import Data.Maybe
import Control.Applicative

numbers :: [String]
numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
  ++ [show x | x <- [1..9]]

numbersClean :: String -> Char
numbersClean "one" = '1'
numbersClean "two" = '2'
numbersClean "three" = '3'
numbersClean "four" = '4'
numbersClean "five" = '5'
numbersClean "six" = '6'
numbersClean "seven" = '7'
numbersClean "eight" = '8'
numbersClean "nine" = '9'
numbersClean x = head x

getPrefix :: String -> String -> Maybe String
getPrefix xs ys
  | xs `isPrefixOf` ys = Just xs
  | otherwise = Nothing

firstNumber :: String -> String
firstNumber xs = fromMaybe (firstNumber (tail xs)) $ listToMaybe (mapMaybe (`getPrefix` xs) numbers)

getSuffix :: String -> String -> Maybe String
getSuffix xs ys
  | xs `isSuffixOf` ys = Just xs
  | otherwise = Nothing

lastNumber :: String -> String
lastNumber xs = fromMaybe (lastNumber (init xs)) $ listToMaybe (mapMaybe (`getSuffix` xs) numbers)

solve :: String -> Int
solve = sum . map (\x -> read [numbersClean $ firstNumber x, numbersClean $ lastNumber x]) . lines

main :: IO ()
main = do
  readFile "test.txt" >>= print . solve
  readFile "input.txt" >>= print . solve
