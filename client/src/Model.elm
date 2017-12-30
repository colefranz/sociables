module Model exposing (..)

type alias Model =
  { setup: Setup
  }

type alias Setup =
  { input : String
  , players : List String
  }

initialModel : Model
initialModel =
    { setup = Setup "" []
    }
