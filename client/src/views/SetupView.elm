module SetupView exposing (..)

import Model exposing (Setup)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import EventHelpers exposing (..)
import Msgs exposing (..)


playerSetup : Setup -> Html Msg
playerSetup setup =
    div [ class "player-setup" ]
        [ input
            [ type_ "text"
            , value setup.input
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
