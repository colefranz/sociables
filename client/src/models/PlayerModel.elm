module PlayerModel exposing (..)


type alias Player =
    String


type alias Players =
    { list : List Player
    , turn : Int
    }


initialPlayers : Players
initialPlayers =
    Players [] -1


playersAfterDraw : Players -> Players
playersAfterDraw players =
    if players.turn == List.length players.list - 1 then
        { players | turn = 0 }
    else
        { players | turn = players.turn + 1 }


addPlayer : Players -> String -> Players
addPlayer oldPlayers newPlayer =
    let
        newPlayerList =
            oldPlayers.list ++ [ newPlayer ]

        newPlayers =
            { oldPlayers | list = newPlayerList }

        newTurn =
            if List.length oldPlayers.list == 0 then
                0
            else
                oldPlayers.turn
    in
        Players newPlayerList newTurn
