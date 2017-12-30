import Html exposing (..)
import Model exposing (initialModel, Model)
import Msgs exposing (Msg)
import View exposing (view)
import Update exposing (update)

main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- Init the model

init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)

-- No Subscriptions

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


