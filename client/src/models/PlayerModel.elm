module PlayerModel exposing (..)

import Array exposing (get, fromList)


type alias Player =
    String


type alias Players =
    { list : List Player
    , turn : Int
    , playerToSwap : Int
    }


type alias PlayerIndex =
    String


initialPlayers : Players
initialPlayers =
    Players [] -1 -1


emptyPlayer : Player
emptyPlayer =
    ""


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
        Players newPlayerList newTurn oldPlayers.playerToSwap


swapPlayers : Players -> Int -> Players
swapPlayers oldPlayers newPlayer =
    let
        newPlayers =
            if oldPlayers.playerToSwap == -1 then
                { oldPlayers | playerToSwap = newPlayer }
            else
                { oldPlayers | list = (swapPlayersInList oldPlayers.list newPlayer oldPlayers.playerToSwap), playerToSwap = -1 }
    in
        newPlayers


swapPlayersInList : List Player -> Int -> Int -> List Player
swapPlayersInList oldPlayersList swapIndex1 swapIndex2 =
    let
        firstName =
            getPlayer oldPlayersList swapIndex1

        secondName =
            getPlayer oldPlayersList swapIndex2

        partiallySwappedPlayerList =
            List.indexedMap (swapPlayer swapIndex2 firstName) oldPlayersList

        swappedPlayerList =
            List.indexedMap (swapPlayer swapIndex1 secondName) partiallySwappedPlayerList
    in
        swappedPlayerList


getPlayer : List Player -> Int -> Player
getPlayer playerList playerIndex =
    let
        maybePlayer =
            get playerIndex (fromList playerList)
    in
        case maybePlayer of
            Just player ->
                player

            Nothing ->
                emptyPlayer


swapPlayer : Int -> Player -> Int -> Player -> Player
swapPlayer playerIndexToReplace playerToReplace playerIndexToCompare playerToCompare =
    if playerIndexToReplace == playerIndexToCompare then
        playerToReplace
    else
        playerToCompare



-- doTheThing : Player -> Int -> Int -> List Player
