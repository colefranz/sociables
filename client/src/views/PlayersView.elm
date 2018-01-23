module PlayersView exposing (..)

import Model exposing (Model)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import EventHelpers exposing (onEnter)
import Msgs exposing (..)


addPlayerInput : Model -> Html Msg
addPlayerInput model =
    div [ class "player-setup" ]
        [ input
            [ type_ "text"
            , value model.playerInput
            , placeholder "Player Name"
            , onEnter AddPlayer
            , autofocus True
            , onInput AddPlayerInputChange
            ]
            []
        , div
            [ class "button"
            , onClick AddPlayer
            ]
            [ text "+" ]
        ]


players : Model -> Html Msg
players model =
    div [ class "players" ] (List.indexedMap (player model.players.turn) model.players.list)


player : Int -> Int -> String -> Html msg
player turnIndex playerIndex playerName =
    let
        className =
            if turnIndex == playerIndex then
                "player is-turn"
            else
                "player"
    in
        div [ class className ] [ text playerName ]
