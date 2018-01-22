module Main exposing (..)

import Html exposing (..)
import Model exposing (initialModel, Model)
import Msgs exposing (..)
import View exposing (view)
import Update exposing (update)
import Random exposing (generate)
import Random.List exposing (shuffle)
import CardModel exposing (deckOfCards)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Init the model


init : ( Model, Cmd Msg )
init =
    ( initialModel, generate SetCards (shuffle deckOfCards) )



-- No Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
