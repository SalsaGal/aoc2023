module Main where
import           Data.Char
import           Data.Maybe

data Game = Game
  { gameId :: Int
  , beads  :: [[(String, Int)]]
  } deriving Show

split :: Char -> String -> [String]
split _ "" = []
split c xs
  | c `elem` xs = takeWhile (/= c) xs : split c (tail $ dropWhile (/= c) xs)
  | otherwise = [xs]

parseGame :: String -> Game
parseGame line = Game
  (read $ drop 5 $ takeWhile (/= ':') line)
  (map (map ((\(num, color) -> (tail color, read num :: Int)) . span (/= ' ') . tail) . split ',') $ split ';' $ tail $ dropWhile (/= ':') line)

solve :: String -> Int
solve = sum . map (product . map snd . maxOf . concat . beads . parseGame) . lines

maxOf :: [(String, Int)] -> [(String, Int)]
maxOf = foldl (\acc (color, num) ->
    [(cColor, if color == cColor then max num cNum else cNum) | (cColor, cNum) <- acc]
  ) [("red", 0), ("green", 0), ("blue", 0)]

main :: IO ()
main = do
  readFile "test.txt" >>= print . solve
  readFile "input.txt" >>= print . solve
