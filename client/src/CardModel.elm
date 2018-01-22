module CardModel exposing (..)


type alias Face =
    String


enumFace : List Face
enumFace =
    [ "Ace"
    , "Two"
    , "Three"
    , "Four"
    , "Five"
    , "Six"
    , "Seven"
    , "Eight"
    , "Nine"
    , "Ten"
    , "Jack"
    , "Queen"
    , "King"
    ]


type alias Suit =
    String


enumSuit : List Suit
enumSuit =
    [ "Spades"
    , "Clubs"
    , "Hearts"
    , "Diamonds"
    ]


type alias Card =
    { face : Face
    , suit : Suit
    }


deckOfCards : List Card
deckOfCards =
    List.concat (List.map suits enumSuit)


suits : Suit -> List Card
suits suit =
    List.map (faces suit) enumFace


faces : Suit -> Face -> Card
faces suit face =
    Card face suit
