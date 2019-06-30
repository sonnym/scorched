module Scorched.Model.Player exposing (firstPlayer, cycleSelection)

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  View(..),
  Modal(..),
  PlayerColor(..),
  Model,
  Player)

import Scorched.Model.Helper as Helper

firstPlayer : PlayerColor
firstPlayer = Red

cycleSelection : Model -> PlayerColor -> (Model, Cmd Msg)
cycleSelection ({config, players} as model) playerColor =
  let
    newPlayers = players ++ List.singleton (create playerColor)
    newModel = { model | players = newPlayers }

    nextColor = List.head (List.drop (List.length newPlayers) colors)
  in
    if List.length players < config.playerCount then
      case nextColor of
        Just color -> (newModel, Helper.send (BasicMsg_ (UpdateView (ModalView (PlayerSelection color)))))
        Nothing -> (newModel, Cmd.none)
    else
      (newModel, Cmd.none)

colors : List PlayerColor
colors = [Red, Green, Purple]

create : PlayerColor -> Player
create playerColor = { color = playerColor }
