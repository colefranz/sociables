module RulesView exposing (rules)

import Html exposing (..)
import Msgs exposing (..)
import Html.Attributes exposing (..)
import Rules exposing (Rule, rulesList)

rules : Html Msg
rules =
    div [ class "rules" ]
        [ h1 []
            [ text "Rules" ]
        , div []
            (List.map renderRule rulesList)
        ]

renderRule : Rule -> Html Msg
renderRule rule =
    p [ class rule.cardFace ]
        [ text (getTextForRule rule) ]

getTextForRule : Rule -> String
getTextForRule rule =
    rule.cardFace ++ ": " ++ rule.description
