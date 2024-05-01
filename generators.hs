import Test.QuickCheck

myList :: Arbitrary a => Gen [a]
myList = oneof
  [ return []
  , (:) <$> arbitrary <*> myList
  ]

myList' :: Arbitrary a => Gen [a]
myList' = frequency
  [ (1, return [])
  , (4, (:) <$> arbitrary <*> myList')
  ]

flexList :: Arbitrary a => Gen [a]
flexList = sized $ \n ->
  frequency
    [ (1, return [])
    , (n, (:) <$> arbitrary <*> flexList)
    ]