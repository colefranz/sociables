module Model exposing (..)

import CardModel exposing (..)
import RulesModel exposing (initialRulesList, Rule)
import PlayerModel exposing (initialPlayers, Players)


type alias Model =
    { playerInput : String
    , players : Players
    , cards : List Card
    , discards : List Card
    , rules : List Rule
    }


initialModel : Model
initialModel =
    { playerInput = ""
    , players = initialPlayers
    , cards = deckOfCards
    , discards = []
    , rules = initialRulesList
    }
