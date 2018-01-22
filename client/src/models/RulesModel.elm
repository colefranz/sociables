module RulesModel exposing (..)

import Array exposing (..)
import CardModel exposing (enumFaceName, FaceName)


type alias RuleDescription =
    String


type alias Rule =
    { cardFace : FaceName
    , description : String
    , active : Bool
    }


possibleRules : Array RuleDescription
possibleRules =
    fromList
        [ "Sociables!!!" -- default ace
        , "R: Take 2, B: Give 2" -- default 2
        , "Spelling Bee" -- default 3
        , "Shuffle" -- default 4
        , "Most Likely To" -- default 5
        , "Never Have I Ever" -- default 6
        , "Sevens" -- default 7
        , "Thumbs!!!" -- default 8
        , "Rock Paper Scissors" -- default 9
        , "Rhyme Relate" -- default 10
        , "Drinking Partners" -- default jack
        , "Girls Drink" -- default queen
        , "Boys Drink" -- default king
        , "unused rule"

        -- add more rules
        -- no idea if this makes picking rules easy. probably not..
        ]


initialRulesList : List Rule
initialRulesList =
    List.indexedMap (getRule) enumFaceName


getRule : Int -> FaceName -> Rule
getRule index faceName =
    let
        maybeRule =
            Array.get index possibleRules
    in
        case maybeRule of
            Just rule ->
                Rule faceName rule False

            Nothing ->
                Rule faceName "" False
