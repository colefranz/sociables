module PlayerModel exposing (..)

import CardModel exposing (blankCard, Card)
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
        playersWithDrawnCardUpdated = updatePlayersWithNewAttachedCard drawnCard players
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
        players


updatePlayersWithNewAttachedCard : Card -> Players -> Players
updatePlayersWithNewAttachedCard drawnCard players =
    let
        playerWhoDrew = getPlayer players.list players.turn
        playerWhoHadCard = playerWithCard players.list drawnCard
        -- cole you need to hold the index of the player who had the card and then
        -- update the card list for each players and then use swap players to put them back in
    in
        players


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
        firstName =
            getPlayer oldPlayersList swapIndex1

        secondName =
            getPlayer oldPlayersList swapIndex2

        partiallySwappedPlayerList =
            List.indexedMap (replacePlayer swapIndex2 firstName) oldPlayersList

        swappedPlayerList =
            List.indexedMap (replacePlayer swapIndex1 secondName) partiallySwappedPlayerList
    in
        swappedPlayerList

playerWithCard : List Player -> Card -> Player
playerWithCard playerList drawnCard =
    let
        maybePlayerIndex =
            findIndex (playerHasCard drawnCard) playerList
        playerIndex =
            case maybePlayerIndex of
                Just index ->
                    index

                Nothing ->
                    -1
    in
        getPlayer playerList playerIndex


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
