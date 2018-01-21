module Msgs exposing (..)

import Card exposing (Card)


type Msg
    = AddPlayerInputChange String
    | AddPlayer
    | DrawCard
    | NoOp
    | SetCards (List Card)
