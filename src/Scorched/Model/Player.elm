module Scorched.Model.Player exposing (generator, firstPlayer, cycleSelection)

import Random
import Random.Extra

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

generator : List Player -> Int -> Random.Generator (List Player)
generator players max =
  Random.map2
    (List.map2 updatePosition)
      (Random.list (List.length players) (Random.map (\x -> { x = x, y = 0 }) (Random.int 0 max)))
      (Random.Extra.sequence (List.map (Random.constant) players))

firstPlayer : PlayerColor
firstPlayer = Red

cycleSelection : Model -> PlayerColor -> (Model, Cmd Msg)
cycleSelection ({config, world} as model) playerColor =
  let
    newPlayers = world.players ++ List.singleton (create playerColor)

    newWorld = { world | players = newPlayers }
    newModel = { model | world = newWorld }

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
create playerColor =
  { color = playerColor
  , position = { x = 0, y = 0 }
  }

updatePosition : Point -> Player -> Player
updatePosition position player = { player | position = position }
