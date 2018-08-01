module PlayersView exposing (..)

import Model exposing (Model)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import EventHelpers exposing (onEnter)
import Msgs exposing (..)
import PlayerModel exposing (Player)


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
    let
        numberOfPlayers = List.length model.players.list
        turnIndex = model.players.turn
        swapIndex = model.players.playerToSwap
    in
        div [ class "players" ] (List.indexedMap (player numberOfPlayers turnIndex swapIndex) model.players.list)


player : Int -> Int -> Int -> Int -> Player -> Html Msg
player numberOfPlayers turnIndex swapIndex playerIndex player =
    let
        className = "player" |> addTurnClass turnIndex playerIndex |> addSwapClass swapIndex playerIndex
    in
        div
            [ class className
            , onClick (SwapPlayer playerIndex)
            , (getPlayerStyle numberOfPlayers playerIndex)
            ]
            [ span [ class "player-name" ] [ text player.name ]
            , span [ class "drawing" ] [ text "Drawing" ]
            ]


addTurnClass : Int -> Int -> String -> String
addTurnClass turnIndex playerIndex class =
    if turnIndex == playerIndex then
        class ++ " is-turn"
    else
        class


addSwapClass : Int -> Int -> String -> String
addSwapClass swapIndex playerIndex class =
    if swapIndex == playerIndex then
        class ++ " is-swapping"
    else
        class


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
