module Scorched.Model.Player exposing (generator, firstPlayer, cycleSelection)

import Random

import Scorched.Model.Types exposing (
  Msg(..),
  GameMsg(..),
  BasicMsg(..),
  View(..),
  Modal(..),
  PlayerColor(..),
  Model,
  Config,
  Player,
  Point)

import Scorched.Model.Helper as Helper

generator : Config -> Random.Generator (List Int)
generator {playerCount, worldConfig} =
  Random.list playerCount (Random.int 0 worldConfig.dimensions.width)

firstPlayer : PlayerColor
firstPlayer = Red

cycleSelection : Model -> PlayerColor -> (Model, Cmd Msg)
cycleSelection ({config, players} as model) playerColor =
  let
    newPlayers = players ++ List.singleton (create playerColor)
    newModel = { model | players = newPlayers }

    nextColor = List.head (List.drop (List.length newPlayers) colors)
  in
    if List.length newPlayers < config.playerCount then
      case nextColor of
        Just color -> (newModel, Helper.send (BasicMsg_ (UpdateView (ModalView (PlayerSelection color)))))
        Nothing -> (newModel, Cmd.none)
    else
      (newModel, Helper.send (GameMsg_ Initialize))

colors : List PlayerColor
colors = [Red, Green, Purple, Yellow, Aqua, Fuchsia, White, Orange, Mint, Blue]

create : PlayerColor -> Player
create playerColor = { color = playerColor }
