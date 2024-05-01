# Seminararbeit-Quickcheck

## Quickcheck
### Einführung
- Bibliothek für zufälliges Testen der Programm**eigenschaften**.
- automatische Testgenerierung
- man definiert Eigenschaften, welche die Funktionen erfüllen sollen (Sortierfunktion soll sortierte Liste zurückgeben).
- Eine Eigenschaft eines ist eine Beobachtung von der wir erwarten, dass sie egal der Eingabe wahr ist (Die Länge eines Stings bleibt nach Anwendung von `reverse` gleich).
- bei einem Fehler wird versucht das Problem einzugrenzen
- Erste Implementierung von QuickCheck in Haskell und inzwischen in über 30 Sprachen übernommen.

### Vorraussetzungen
Quickcheck Bibliothek muss installiert sein:
```
cabal install --lib QuickCheck
```

Code Coverage (optional):
```
stack test --coverage
```

### Generators
- Werden verwendet um Werte zu erzeugen
```
-- generate :: Gen a -> IO a

-- produce 1, 2, or 3
generate $ elements [1,2,3]

-- produce a lowercase letter
generate $ choose ('a', 'z')

-- produce a constant value (since Gen has a Monad instance)
generate $ return 1
```

### Arbitraty
- Produziert Generators
- Stellt standard Generatoren für basic typen.

```
generate (arbitrary :: Gen Bool)
generate (arbitrary :: Gen [(Int, Bool)])
 data MyType = MyType {    foo :: Int  , bar :: Bool  , baz :: Float  } deriving (Show)
 generate $ MyType <$> arbitrary <*> arbitrary <*> arbitrary
```


### Beispiel


## FP in Haskell
- Rekursion
- Pattern Matching
- 

## Typeclasses
- 

konkretes beispiel
