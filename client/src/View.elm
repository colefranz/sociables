module View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (placeholder, type_, value)
import EventHelpers exposing (..)
import Model exposing (Model)
import Msgs exposing (..)

view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.setup.players)
    , input [ type_ "text"
            , value model.setup.input
            , placeholder "Player Name"
            , onEnter AddPlayer
            , onInput AddPlayerInputChange ] []
    , button [ onClick AddPlayer ] [ text "+" ]
    ]


viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]
