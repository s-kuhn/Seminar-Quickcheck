-- | QuickCheck light.
-- The following is re-implementation of the essential features of QuickCheck.

import System.Random (randomIO)
import Data.Char (chr)

class Arbitrary a where
   arbitrary :: IO a

-- Some generators

-- | Choose one of the elements.
elements :: [a] -> IO a
elements xs = do i <- randomIO :: IO Int
                 return (xs !! (i `mod` (length xs)))

-- | Generate a fixed number of arbitrary values.
vector ::  Arbitrary a => Int -> IO [a]
vector 0 = return []
vector n
    | n > 0  = do x <- arbitrary
                  xs <- vector (n-1)
                  return (x:xs)
    | otherwise = error "impossible"


-- Some Arbitrary instances

instance Arbitrary Char where
   arbitrary = do x <- elements [0..255]
                  return (chr x)

instance Arbitrary a => Arbitrary [a] where
   arbitrary = vector 5

instance (Arbitrary a, Arbitrary b) => Arbitrary (Either a b) where
   arbitrary = do b <- randomIO
                  if b
                    then do Left <$> arbitrary
                    else do r <- arbitrary
                            return $ Right r


-- | Random generation of strings
genStrings :: IO ()
genStrings = do xs <- arbitrary
                putStrLn xs

-- | Quickly check a property by testing the property
-- against 100 arbitrarily generated test inputs.
quickCheck :: (Show t, Arbitrary t) => (t -> Bool) -> IO ()
quickCheck prop = go 100
   where go 0 = putStrLn "+++ Ok"
         go n = do x <- arbitrary
                   if prop x
                     then go (n-1)
                     else do putStrLn "*** Failed: "
                             print x



-- Property-based testing for count

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