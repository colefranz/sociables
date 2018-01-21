module CardsView exposing (..)

import Card exposing (..)
import EventHelpers exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msgs exposing (..)


cards : Model -> Html Msg
cards model =
    div [ class "cards" ]
        -- style this so that a stack of cards seems to form
        [ viewCard (List.head model.cards) "facedown" DrawCard
        , viewCard (List.head model.discards) "faceup" NoOp
        ]


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
