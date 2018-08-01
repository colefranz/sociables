module CardModel exposing (..)

import Array exposing (..)
import Helpers exposing (findIndex)


type alias FaceName =
    String


enumFaceName : List FaceName
enumFaceName =
    [ "A"
    , "2"
    , "3"
    , "4"
    , "5"
    , "6"
    , "7"
    , "8"
    , "9"
    , "10"
    , "J"
    , "Q"
    , "K"
    ]


type alias Face =
    Int


type alias Suit =
    String


type alias Card =
    { face : Face
    , suit : Suit
    }


enumSuit : List Suit
enumSuit =
    [ "Spades"
    , "Clubs"
    , "Hearts"
    , "Diamonds"
    ]


deckOfCards : List Card
deckOfCards =
    List.concat (List.map suits enumSuit)


suits : Suit -> List Card
suits suit =
    List.map (faces suit) (List.range 0 12)


faces : Suit -> Face -> Card
faces suit face =
    Card face suit


getFaceName : Face -> FaceName
getFaceName face =
    let
        maybeFaceName =
            Array.get face (fromList enumFaceName)
    in
        case maybeFaceName of
            Just faceName ->
                faceName

            Nothing ->
                ""

getFace : FaceName -> Face
getFace faceName =
    let
        maybeFace =
            findIndex ((==) faceName) enumFaceName
    in
        case maybeFace of
            Just face ->
                face

            Nothing ->
                0


blankCard : Card
blankCard =
    Card -1 ""


getTopCard : List Card -> Card
getTopCard cards =
    case (List.head cards) of
        Just card ->
            card

        Nothing ->
            blankCard
