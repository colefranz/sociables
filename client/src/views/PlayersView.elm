module PlayersView exposing (..)

import Model exposing (Model)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import EventHelpers exposing (onEnter)
import Msgs exposing (..)


addPlayerInput : Model -> Html Msg
addPlayerInput model =
    div [ class "add-player" ]
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
    div [ class "players" ] (List.indexedMap (player (List.length model.players.list) model.players.turn) model.players.list)


player : Int -> Int -> Int -> String -> Html Msg
player numberOfPlayers turnIndex playerIndex playerName =
    let
        className =
            if turnIndex == playerIndex then
                "player is-turn"
            else
                "player"
    in
        div
            [ class className
            , onClick (SwapPlayer playerIndex)
            , (getPlayerStyle numberOfPlayers playerIndex)
            ]
            [ span [ class "player-name" ] [ text playerName ]
            , span [ class "drawing" ] [ text "Drawing" ]
            ]


getPlayerStyle : Int -> Int -> Attribute msg
getPlayerStyle numberOfPlayers index =
    let
        rads =
            ((toFloat index) / (toFloat numberOfPlayers)) * 2 * pi

        radius =
            toFloat 230

        xOffset =
            cos (rads)

        yOffset =
            sin (rads)
    in
        style
            [ ( "position", "absolute" )
            , ( "left", (offsetAndCenter xOffset playerRadius radius) )
            , ( "top", (offsetAndCenter yOffset playerRadius radius) )
            , ( "width", (asStringWithPixels playerRadius) )
            , ( "height", (asStringWithPixels playerRadius) )
            , ( "border-radius", (asStringWithPixels (playerRadius / 2)) )
            ]


offsetAndCenter : Float -> Float -> Float -> String
offsetAndCenter offsetPercent elementSize circleRadius =
    let
        elementOffset =
            elementSize / 2

        offset =
            (toString ((offsetPercent * circleRadius) - elementOffset)) ++ "px"
    in
        "calc(50% + " ++ offset ++ ")"


playerRadius : Float
playerRadius =
    100


asStringWithPixels : Float -> String
asStringWithPixels num =
    (toString num) ++ "px"
