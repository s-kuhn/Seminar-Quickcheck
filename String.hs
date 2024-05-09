import Test.QuickCheck
import Control.Monad (replicateM)

stringGen = do
  n <- chooseInt (0, 40)
  xs <- replicateM n (frequency [(1, elements ['a'..'z']), (1, elements [' '])])
  return xs