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
        [ div [ class "deck facedown", deckStyle model.cards ] (List.map (viewCard DrawCard) model.cards)
        , div [ class "deck faceup", deckStyle model.discards ] (List.map (viewCard NoOp) model.discards)
        ]


viewCard : Msg -> Card -> Html Msg
viewCard msg card =
    div
        [ class ("card")
        , onClick msg
        ]
        [ cardFront card
        , div [ class "card-side back" ] [ p [] [ text "Draw Me!" ] ]
        ]


cardFront : Card -> Html Msg
cardFront card =
    div [ class ("card-side front " ++ card.suit) ]
        [ p [] [ text (getFaceName card.face) ]
        ]


deckStyle : List Card -> Attribute Msg
deckStyle deck =
    style [ ( "-webkit-box-shadow", deckBoxShadow deck ) ]


deckBoxShadow : List Card -> String
deckBoxShadow deck =
    let
        indexedDeck =
            List.indexedMap (,) deck
    in
        List.foldl boxShadow "0px 0px black" indexedDeck


boxShadow : ( Int, Card ) -> String -> String
boxShadow ( index, card ) cumulativeShadow =
    cumulativeShadow ++ ", " ++ (pixel index) ++ " " ++ (pixel index) ++ " " ++ "0px " ++ "#BCA0A4"


pixel : Int -> String
pixel value =
    let
        valueAsFloat =
            toFloat value

        eighth =
            valueAsFloat / 8
    in
        toString (eighth) ++ "px"
