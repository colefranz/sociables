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
        [ div [ class "deck facedown" ] (List.map (viewCard DrawCard) model.cards)
        , div [ class "deck faceup" ] (List.map (viewCard NoOp) model.discards)
        ]


viewCard : Msg -> Card -> Html Msg
viewCard msg card =
    div
        [ class ("card")
        , onClick msg
        ]
        -- potentially give each a front and a back for flipping
        [ div [ class card.suit ] [ p [] [ text (getFaceName card.face) ] ]
        ]
