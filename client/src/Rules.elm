module Rules exposing (..)

import Card exposing (Face)


type alias Rule =
    { cardFace : Face
    , description : String
    }


rulesList : List Rule
rulesList =
    [ Rule "Ace" "Sociables!!!"
    , Rule "Two" "R: Take 2, B: Give 2"
    , Rule "Three" "Threes"
    , Rule "Four" "Fours"
    , Rule "Five" "Fives"
    , Rule "Six" "Sixs"
    , Rule "Seven" "Sevens"
    , Rule "Eight" "Eights"
    , Rule "Nine" "Nines"
    , Rule "Ten" "Tens"
    , Rule "Jack" "Jacks"
    , Rule "Queen" "Queens"
    , Rule "King" "Kings"
    ]
