-- QuickCheck by example
import Test.QuickCheck


-- | Counting words.
-- Word = Sequence of characters not separated by white spaces (blanks).
count :: String -> Int
count [] = 0
count (c:cs)
  | c == ' ' = count $ skipBlanks cs
  | otherwise = 1 + count (skipWord cs)

-- | Generic skip function.
skip :: (Char -> Bool) -> String -> String
skip p [] = []
skip p (c:cs)
 | p c       = skip p cs
 | otherwise = c:cs

skipWord   = skip (/= ' ')
skipBlanks = skip (== ' ')



-- | Number of words counted must be greater or equal zero.
prop1 :: String -> Bool
prop1 s = count s >= 0

-- | Reversing the string yields the same number of words.
prop2 :: String -> Bool
prop2 s = count s == count (reverse s)


-- | Concatenating the string doubles the number of words.
-- NOTE: This property does not hold in general!
prop3 :: String -> Bool
prop3 s = 2 * count s == count (s ++ s)

quickCheckN n = quickCheckWith $ stdArgs { maxSuccess = n }

verboseCheckN n = verboseCheckWith $ stdArgs { maxSuccess = n }