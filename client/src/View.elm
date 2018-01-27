module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msgs exposing (..)
import RulesView exposing (rules)
import PlayersView exposing (addPlayerInput, players)
import CardsView exposing (cards)


view : Model -> Html Msg
view model =
    div [ id "elm-main" ]
        [ rules model
        , div
            [ id "sitting-area" ]
            [ addPlayerInput model
            , players model
            , cards model
            ]
        ]
