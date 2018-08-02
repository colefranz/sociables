module PlayerModel exposing (..)

import CardModel exposing (..)
import Array exposing (..)
import Helpers exposing (findIndex)


type alias Player =
    { name : String
    , heldCards : List Card
    }


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
    Player "" []


playersAfterDrawWithPersistentCard : Card -> Players -> Players
playersAfterDrawWithPersistentCard drawnCard players =
    let
        playersWithDrawnCardUpdated =
            updatePlayersWithNewAttachedCard drawnCard players
    in
        playersAfterDraw playersWithDrawnCardUpdated


playersAfterDraw : Players -> Players
playersAfterDraw players =
    let
        newPlayers =
            if players.turn == List.length players.list - 1 then
                { players | turn = 0 }
            else
                { players | turn = players.turn + 1 }
    in
        newPlayers


updatePlayersWithNewAttachedCard : Card -> Players -> Players
updatePlayersWithNewAttachedCard drawnCard players =
    let
        indexOfPlayerWhoDrew =
            players.turn

        playerWhoDrew =
            getPlayer players.list players.turn

        updatedPlayerWhoDrew =
            { playerWhoDrew | heldCards = (addHeldCard playerWhoDrew.heldCards drawnCard) }

        updatedPlayersList =
            List.indexedMap (replacePlayer players.turn updatedPlayerWhoDrew) players.list

        maybeIndexOfPlayerWhoHadCard =
            findIndex (playerHasCard drawnCard) players.list

        updatedPlayerList =
            case maybeIndexOfPlayerWhoHadCard of
                Just index ->
                    -- DEFECT NOT WORKING
                    removeCardFromPlayerAndReplaceInList index drawnCard updatedPlayersList

                Nothing ->
                    updatedPlayersList
    in
        { players | list = updatedPlayersList }


removeCardFromPlayerAndReplaceInList : Int -> Card -> List Player -> List Player
removeCardFromPlayerAndReplaceInList indexOfPlayerWhoDrew drawnCard playerList =
    let
        playerWhoHadCard =
            getPlayer playerList indexOfPlayerWhoDrew

        updatedPlayerWhoHadCard =
            { playerWhoHadCard | heldCards = (removeHeldCard playerWhoHadCard.heldCards drawnCard) }
    in
        List.indexedMap (replacePlayer indexOfPlayerWhoDrew updatedPlayerWhoHadCard) playerList


addPlayer : Players -> String -> Players
addPlayer oldPlayers newPlayer =
    let
        newPlayerList =
            oldPlayers.list ++ [ Player newPlayer [] ]

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
        firstPlayer =
            getPlayer oldPlayersList swapIndex1

        secondPlayer =
            getPlayer oldPlayersList swapIndex2

        partiallySwappedPlayerList =
            List.indexedMap (replacePlayer swapIndex2 firstPlayer) oldPlayersList

        swappedPlayerList =
            List.indexedMap (replacePlayer swapIndex1 secondPlayer) partiallySwappedPlayerList
    in
        swappedPlayerList


playerHasCard : Card -> Player -> Bool
playerHasCard drawnCard player =
    List.member drawnCard player.heldCards


getPlayer : List Player -> Int -> Player
getPlayer playerList playerIndex =
    let
        maybePlayer =
            Array.get playerIndex (Array.fromList playerList)
    in
        case maybePlayer of
            Just player ->
                player

            Nothing ->
                emptyPlayer


replacePlayer : Int -> Player -> Int -> Player -> Player
replacePlayer replacerIndex replacer replaceyIndex replacey =
    if replacerIndex == replaceyIndex then
        replacer
    else
        replacey



-- doTheThing : Player -> Int -> Int -> List Player
