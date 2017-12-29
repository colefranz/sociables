import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (placeholder, type_, value)
import EventHelpers exposing (..)


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { input : String
  , players : List String
  }


init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)


-- UPDATE

type Msg
  = Input String
  | AddPlayer


update : Msg -> Model -> (Model, Cmd Msg)
update msg {input, players} =
  case msg of
    Input newInput ->
      (Model newInput players, Cmd.none)

    AddPlayer ->
      (Model "" (input :: players), Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.players)
    , input [ type_ "text"
            , value model.input
            , placeholder "Player Name"
            , onEnter AddPlayer
            , onInput Input ] []
    , button [ onClick AddPlayer ] [ text "+" ]
    ]


viewMessage : String -> Html msg
viewMessage msg =
  div [] [ text msg ]
