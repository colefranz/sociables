module RulesModel exposing (..)

import CardModel exposing (enumFaceName, FaceName)


type alias RuleDescription =
    String


type alias Rule =
    { cardFace : FaceName
    , description : String
    , active : Bool
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


initialRulesList : List Rule
initialRulesList =
    List.map2 createRule enumFaceName possibleRules


createRule : FaceName -> RuleDescription -> Rule
createRule faceName ruleDescription =
    Rule faceName ruleDescription False
