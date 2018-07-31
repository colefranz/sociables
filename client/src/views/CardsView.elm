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
        , div [ class "card-side back" ] [ p [] [] ]
        ]


cardFront : Card -> Html Msg
cardFront card =
    div [ class ("card-side front " ++ card.suit) ]
        [ faceText card "left"
        , div [ class "face-icon" ] []
        , faceText card "right"
        ]


faceText : Card -> String -> Html Msg
faceText card className =
    p [ class className ] [ text (getFaceName card.face) ]


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
    cumulativeShadow ++ ", " ++ (pixel index) ++ " " ++ (pixel index) ++ " " ++ "0px " ++ "#0F0F0F"


pixel : Int -> String
pixel value =
    let
        valueAsFloat =
            toFloat value

        eighth =
            valueAsFloat / 8
    in
        toString (eighth) ++ "px"
