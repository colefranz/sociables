module Model exposing (..)

import CardModel exposing (..)


type alias Model =
    { setup : Setup
    , cards : List Card
    , discards : List Card
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
    }
