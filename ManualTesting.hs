-- Tests/Assertions in Haskell

-- | Counting words.
-- Word = Sequence of characters not separated by white spaces (blanks).
count [] = 0
count (c:cs)
  | c == ' ' = count $ skipBlanks cs
  | otherwise = 1 + count (skipWord cs)

-- | Generic skip function.
skip p [] = []
skip p (c:cs)
 | p c       = skip p cs
 | otherwise = c:cs

skipWord   = skip (/= ' ')
skipBlanks = skip (== ' ')


-- Boilerplate code for writing tests
type Assertion = IO ()
assertEqual :: (Eq a, Show a) => String -> a -> a -> Assertion
assertEqual what expected given =
    if expected == given
    then putStrLn ("[ok] " ++ what)
    else fail
             (what ++ ": assertEqual failed. Expected: " ++ show expected ++
               ", given: " ++ show given)


test_count :: Assertion
test_count = do assertEqual "Test1" 0 (count "")
                assertEqual "Test2" 1 (count "Hallo  ")
                assertEqual "Test3" 2 (count "Hallo  123")
                assertEqual "Test4" 2 (count "Hallo  123 bcd ")