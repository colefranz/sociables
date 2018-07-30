module Update exposing (..)

import Msgs exposing (..)
import Model exposing (Model)
import RulesModel exposing (Rule)
import CardModel exposing (blankCard, Card)
import PlayerModel exposing (addPlayer, playersAfterDraw, swapPlayers)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg oldModel =
    case msg of
        AddPlayerInputChange newInput ->
            { oldModel | playerInput = newInput } ! []

        AddPlayer ->
            let
                newPlayers =
                    if String.isEmpty oldModel.playerInput then
                        oldModel.players
                    else
                        addPlayer oldModel.players oldModel.playerInput
            in
                { oldModel | playerInput = "", players = newPlayers } ! []

        DrawCard ->
            let
                -- pull cards functionality into the model?
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

                newPlayers =
                    playersAfterDraw oldModel.players

                newRules =
                    List.indexedMap (setActiveRule drawnCard) oldModel.rules
            in
                { oldModel | cards = newCards, discards = newDiscards, rules = newRules, players = newPlayers } ! []

        NoOp ->
            oldModel ! []

        SetCards cards ->
            { oldModel | cards = cards } ! []

        SwapPlayer newPlayer ->
            let
                newPlayers =
                    swapPlayers oldModel.players newPlayer
            in
                { oldModel | players = newPlayers } ! []


setActiveRule : Card -> Int -> Rule -> Rule
setActiveRule card index rule =
    if card.face == index then
        { rule | active = True }
    else
        { rule | active = False }
