module Update exposing (..)

import Msgs exposing (..)
import Model exposing (Setup, Model)


update : Msg -> Model -> (Model, Cmd Msg)
update msg oldModel =
  case msg of
    AddPlayerInputChange newInput ->
      let
        oldSetup =
          oldModel.setup

        newSetup =
          { oldSetup | input = newInput }

      in
        ({ oldModel | setup = newSetup }, Cmd.none)

    AddPlayer ->
      let
        newSetup =
          Setup "" (oldModel.setup.input :: oldModel.setup.players)

      in
        ({ oldModel | setup = newSetup }, Cmd.none)
