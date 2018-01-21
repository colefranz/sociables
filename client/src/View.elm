module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msgs exposing (..)
import RulesView exposing (rules)
import SetupView exposing (playerSetup)
import CardsView exposing (cards)


view : Model -> Html Msg
view model =
    div [ id "elm-main" ]
        [ rules
        , playerSetup model.setup
        , div [ class "players" ] (List.map viewMessage model.setup.players)
        , cards model
        ]


viewMessage : String -> Html msg
viewMessage msg =
    div [ class "player" ] [ text msg ]
