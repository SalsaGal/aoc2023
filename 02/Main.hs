module Main where
import           Data.Char
import           Data.Maybe

beadCount :: [(String, Int)]
beadCount =
  [ ("red", 12)
  , ("green", 13)
  , ("blue", 14)
  ]

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

validGame :: Game -> Bool
validGame = all (all (\(color, num) -> (num <=) $ fromMaybe 0 $ lookup color beadCount)) . beads

solve :: String -> Int
solve = sum . map gameId . filter validGame . map parseGame . lines

main :: IO ()
main = do
  readFile "test.txt" >>= print . solve
  readFile "input.txt" >>= print . solve
