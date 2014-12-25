module Scorched.Model where

import Signal

import Scorched.Action (Action(NoOp, PlayerCount, Start), updates)

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

type View = Menu | Game

type alias Model = {
  view: View,
  playerCount: Int,
  roundCount: Int,
  game: GameState
}

state : Signal Model
state = Signal.foldp step default (Signal.subscribe updates)

step : Action -> Model -> Model
step action model =
  case action of
    NoOp -> model
    PlayerCount value -> { model | playerCount <- value }
    RoundCount value -> { model | roundCount <- value }
    Start ->
      { model | view <- Game
              , game <- GameState.default }

default : Model
default = {
  view = Menu,
  playerCount = 2,
  roundCount = 10,
  game = GameState.default }
