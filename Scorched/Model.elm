module Scorched.Model where

import List
import List ((::), filter, length, head)

import Signal
import Signal (Signal, Message, foldp, subscribe, merge, mergeMany)

import Char (toCode)
import Keyboard (KeyCode)

import Scorched.Input (Input, keypress)

import Scorched.Action (Hook, Action(NoOp, Start), updates)

import Scorched.Model.World (Dimension)

import Scorched.Model.Configuration (Configuration)
import Scorched.Model.Configuration as Configuration

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

import Scorched.Model.View.Menu as MenuModel

type View = Menu | Game

type alias Model = {
  view: View,
  hooks: List Hook,
  dimensions: Dimension,
  config: Configuration,
  game: GameState
}

state : Signal Model
state = foldp step default (Signal.map2 (,) (subscribe updates) keypress)

step : (Action, Input) -> Model -> Model
step (action, input) ({hooks} as model) =
  applicator (action :: (List.map (lookup hooks) input)) model

applicator : List Action -> Model -> Model
applicator actions model =
  case actions of
    action::rest -> applicator rest (apply action model)
    [] -> model

apply : Action -> Model -> Model
apply action model =
  case action of
    NoOp -> model

    Configuration a -> { model | config <- Configuration.step a model.config }

    Start ->
      { model | view <- Game
              , game <- GameState.default }

lookup : List Hook -> KeyCode -> Action
lookup hooks keyCode =
  let
    match = filter (\pair -> (toCode (fst pair)) == keyCode) hooks
  in
    if | length match > 0 -> snd (head match)
       | otherwise -> NoOp

default : Model
default = {
  view = Menu,
  hooks = MenuModel.hooks,
  dimensions = {width=1024, height=768},
  config = Configuration.default,
  game = GameState.default }
