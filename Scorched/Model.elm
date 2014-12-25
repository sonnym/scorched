module Scorched.Model where

import Signal

import Scorched.Action (Action)
import Scorched.Action as Action

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

type View = Menu | Game

type alias Model = {
  view: View,
  playerCount: Int,
  game: GameState
}

state : Signal Model
state = Signal.foldp step default (Signal.subscribe Action.updates)

step : Action -> Model -> Model
step action model =
  case action of
    Action.NoOp -> model
    Action.PlayerCount value -> { model | playerCount <- value }
    Action.Start ->
      { model | view <- Game
              , game <- GameState.default }

default : Model
default = {
  view = Menu,
  playerCount = 2,
  game = GameState.default }
