module Msgs exposing (..)

import CardModel exposing (Card)


type Msg
    = AddPlayerInputChange String
    | AddPlayer
    | DrawCard
    | NoOp
    | SetCards (List Card)
    | SwapPlayer Int
