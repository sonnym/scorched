module Scorched.Model where

import List
import List ((::), foldr, filter, length, head)

import Signal (Signal, Message, foldp, map, map3, constant, subscribe, merge, mergeMany)
import Time (timestamp)

import Char (toCode)
import Keyboard (KeyCode)

import Random (Seed, initialSeed)

import Scorched.Input (Input, keypress)
import Scorched.Action (Hook, Action(NoOp, Start), updates)

import Scorched.Model.Geometry (Dimension)

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
state = foldp step default (map3 (\action input seed -> (action, input, seed)) (subscribe updates) keypress seeds)

seeds : Signal Seed
seeds = map (\(time, _) -> initialSeed (round time)) (timestamp (constant ()))

step : (Action, Input, Seed) -> Model -> Model
step (action, input, seed) ({hooks} as model) =
  let
    actions = action :: (List.map (lookup hooks) input)
  in
    foldr apply model actions

apply : Action -> Model -> Model
apply action model =
  case action of
    NoOp -> model

    Configuration a -> { model | config <- Configuration.step a model.config }

    Start ->
      { model | view <- Game
              , game <- GameState.default dimensions }

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
  dimensions = dimensions,
  config = Configuration.default,
  game = GameState.default dimensions }

dimensions : Dimension
dimensions = {width=1024, height=768}
