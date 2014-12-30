module Scorched.Model where

import Signal (Signal, Message, foldp, subscribe)

import Scorched.Action (Action(NoOp, PlayerCount, Start), updates)

import Scorched.Model.World (Dimension)

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

type View = Menu | Game

type alias Messenger = Int -> Message

type alias Model = {
  view: View,
  dimensions: Dimension,
  playerCount: Int,
  roundCount: Int,
  game: GameState
}

state : Signal Model
state = foldp step default (subscribe updates)

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
  dimensions = {width=1024, height=768},
  playerCount = 2,
  roundCount = 10,
  game = GameState.default }
