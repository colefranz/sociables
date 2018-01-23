module Model exposing (..)

import CardModel exposing (..)
import RulesModel exposing (initialRulesList, Rule)


type alias Model =
    { playerInput : String
    , players : List String
    , cards : List Card
    , discards : List Card
    , rules : List Rule
    }


initialModel : Model
initialModel =
    { playerInput = ""
    , players = []
    , cards = deckOfCards
    , discards = []
    , rules = initialRulesList
    }
