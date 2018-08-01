module Update exposing (..)

import Msgs exposing (..)
import Model exposing (Model)
import RulesModel exposing (getRuleForCard, Rule)
import CardModel exposing (blankCard, Card, getTopCard)
import PlayerModel exposing (..)


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
                newCards =
                    List.drop 1 oldModel.cards

                drawnCard =
                    getTopCard oldModel.cards

                newDiscards =
                    oldModel.discards ++ [drawnCard]

                currentRule =
                    getRuleForCard drawnCard oldModel.rules

                newPlayers =
                    if currentRule.persistent == True then
                        playersAfterDrawWithPersistentCard drawnCard oldModel.players
                    else
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
