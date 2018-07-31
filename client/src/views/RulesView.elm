module RulesView exposing (rules)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msgs exposing (..)
import RulesModel exposing (Rule)


rules : Model -> Html Msg
rules model =
    div [ id "rules" ]
        [ h1 []
            [ text "Rules" ]

        -- Add an option to swap out rules for other rules!
        , div []
            (List.map renderRule model.rules)
        ]


renderRule : Rule -> Html Msg
renderRule rule =
    p [ class ("rule " ++ (ruleIsActive rule)) ]
        [ text (getTextForRule rule) ]


getTextForRule : Rule -> String
getTextForRule rule =
    rule.cardFace ++ ": " ++ rule.description


ruleIsActive : Rule -> String
ruleIsActive rule =
    if rule.active == True then
        "active"
    else
        ""
