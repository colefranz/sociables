module Model exposing (..)

import CardModel exposing (..)
import RulesModel exposing (initialRulesList, Rule)


type alias Model =
    { setup : Setup
    , cards : List Card
    , discards : List Card
    , rules : List Rule
    }


type alias Setup =
    { input : String
    , players : List String
    }


initialModel : Model
initialModel =
    { setup = Setup "" []
    , cards = deckOfCards
    , discards = []
    , rules = initialRulesList
    }
