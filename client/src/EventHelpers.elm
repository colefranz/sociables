module EventHelpers exposing (..)

import Json.Decode as Json
import Html exposing (..)
import Html.Events exposing (..)


onEnter : a -> Attribute a
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail ""
    in
        on "keydown" (Json.andThen isEnter keyCode)
