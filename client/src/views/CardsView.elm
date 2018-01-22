module CardsView exposing (..)

import CardModel exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msgs exposing (..)


cards : Model -> Html Msg
cards model =
    div [ class "cards" ]
        -- style this so that a stack of cards seems to form
        [ div [ class "deck facedown" ] (List.map viewCard model.cards)
        , div [ class "deck faceup" ] (List.map viewCard model.discards)
        ]


viewCard : Card -> Html Msg
viewCard card =
    div
        [ class ("card")
        , onClick DrawCard
        ]
        -- potentially give each a front and a back for flipping
        [ div [ class card.suit ] [ p [] [ text card.face ] ]
        ]
