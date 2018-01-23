module Update exposing (..)

import Msgs exposing (..)
import Model exposing (Model)
import RulesModel exposing (Rule)
import CardModel exposing (blankCard, Card)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg oldModel =
    case msg of
        AddPlayerInputChange newInput ->
            { oldModel | playerInput = newInput } ! []

        AddPlayer ->
            let
                newInput =
                    ""

                newPlayers =
                    oldModel.players ++ [ oldModel.playerInput ]
            in
                { oldModel | playerInput = newInput, players = newPlayers } ! []

        DrawCard ->
            let
                newCards =
                    List.drop 1 oldModel.cards

                newDiscards =
                    oldModel.discards ++ List.take 1 oldModel.cards

                drawnCard =
                    case (List.head oldModel.cards) of
                        Just card ->
                            card

                        Nothing ->
                            blankCard

                newRules =
                    List.indexedMap (setActiveRule drawnCard) oldModel.rules
            in
                { oldModel | cards = newCards, discards = newDiscards, rules = newRules } ! []

        NoOp ->
            oldModel ! []

        SetCards cards ->
            { oldModel | cards = cards } ! []


setActiveRule : Card -> Int -> Rule -> Rule
setActiveRule card index rule =
    if card.face == index then
        { rule | active = True }
    else
        { rule | active = False }
