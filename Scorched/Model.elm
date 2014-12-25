module Scorched.Model where

import Signal

import Graphics.Element (Element)

import Scorched.Action (Action)
import Scorched.Action as Action

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

import Scorched.Model.World as World
import Scorched.Model.Window as Window

import Scorched.View.Menu (renderMenu)
import Scorched.View.GamePlay (renderWorld)

type View = Menu | Game

type alias Model = {
  view: View,
  playerCount: Int,
  game: GameState
}

scene : Model -> Element
scene model =
  case model.view of
    Menu ->
      renderMenu Window.dimensions

    Game ->
      renderWorld (World.default Window.dimensions) Window.dimensions

state : Signal Model
state = Signal.foldp step default (Signal.subscribe Action.updates)

step : Action -> Model -> Model
step action model =
  case action of
    Action.NoOp -> model
    Action.PlayerCount -> { model | playerCount <- model.playerCount + 1 }
    Action.Start -> { model | view <- Game }

default : Model
default = {
  view = Menu,
  playerCount = 2,
  game = GameState.default }
