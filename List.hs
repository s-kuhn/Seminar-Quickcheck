-- Eigener Datentyp Liste
data List a = Nil | Cons a (List a) deriving (Eq, Show)

-- Arbitrary instance for List
instance Arbitrary a => Arbitrary (List a) where
  arbitrary = sized listGen
    where
      listGen n = frequency [(1, return Nil), (4, Cons <$> arbitrary <*> listGen (min 10 (n - 1)))]


-- Um die Funktionalität zu testen, könnten wir eine einfache Funktion definieren:
toList :: List a -> [a]
toList Nil = []
toList (Cons x xs) = x : toList xs
