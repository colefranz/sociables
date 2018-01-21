module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import EventHelpers exposing (..)
import Model exposing (Model)
import Msgs exposing (..)
import Card exposing (..)
import RulesView exposing (rules)
import SetupView exposing (playerSetup)


view : Model -> Html Msg
view model =
    div [ id "elm-main" ]
        [ rules
        , playerSetup model.setup
        , div [ class "players" ] (List.map viewMessage model.setup.players)
        , div [ class "cards" ]
            -- style this so that a stack of cards seems to form
            [ viewCard (List.head model.cards) "facedown" DrawCard
            , viewCard (List.head model.discards) "faceup" NoOp
            ]
        ]


viewMessage : String -> Html msg
viewMessage msg =
    div [ class "player" ] [ text msg ]


cardFront : Maybe Card -> Html msg
cardFront maybeCard =
    case maybeCard of
        Just card ->
            div [ class card.suit ] [ text card.face ]

        Nothing ->
            div [] []


viewCard : Maybe Card -> String -> Msg -> Html Msg
viewCard maybeCard orientation msg =
    div
        [ class ("card " ++ orientation)
        , onClick msg
        ]
        [ cardFront maybeCard
        , div [ class "backside" ] []
        ]
