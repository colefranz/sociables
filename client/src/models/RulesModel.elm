module RulesModel exposing (..)

import CardModel exposing (Card, enumFaceName, getFace, FaceName)


type alias RuleDescription =
    String


type alias Rule =
    { cardFace : FaceName
    , description : String
    , active : Bool
    , persistent : Bool
    }


possibleRules : List RuleDescription
possibleRules =
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

-- add more rules
-- add description to rules?

emptyRule : Rule
emptyRule =
    createRule "" ""


initialRulesList : List Rule
initialRulesList =
    List.map2 createRule enumFaceName possibleRules


createRule : FaceName -> RuleDescription -> Rule
createRule faceName ruleDescription =
    Rule faceName ruleDescription False False


getRuleForCard : Card -> List Rule -> Rule
getRuleForCard card rules =
    let
        maybeRule =
            List.head (List.filter (cardMatchesRule card) rules)
    in
        case maybeRule of
            Just rule ->
                rule

            Nothing ->
                emptyRule


cardMatchesRule : Card -> Rule -> Bool
cardMatchesRule card rule =
    (getFace rule.cardFace) == card.face
