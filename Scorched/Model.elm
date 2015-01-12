module Scorched.Model where

import List
import List ((::), foldr, filter, length, head)

import Signal (Signal, Message, foldp, map, map3, constant, subscribe, merge, mergeMany, sampleOn)
import Time (timestamp, fps)

import Char (toCode)
import Keyboard (KeyCode)

import Random (Seed, initialSeed)

import Scorched.Input (Input, keypress)
import Scorched.Action (Hook, Action(NoOp, Initialize, Start), updates)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.Configuration (Configuration)
import Scorched.Model.Configuration as Configuration

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

import Scorched.Model.View.Menu as MenuModel

type View = Menu | Game

type alias Model = {
  view: View,
  viewData: { game: GameState },
  hooks: List Hook,
  dimensions: Dimension,
  config: Configuration
}

state : Signal Model
state = foldp step default signal

signal : Signal (Action, Input, Seed)
signal =
  let
    actions = merge (constant Initialize) (subscribe updates)
    combination = map3 (\action input seed -> (action, input, seed)) actions keypress seeds
  in
    sampleOn (fps 60) combination

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
    Initialize -> { model | hooks <- MenuModel.hooks
                          , viewData <- {game=GameState.default MenuModel.worldDimensions} }

    Configuration a -> { model | config <- Configuration.step a model.config }

    Start ->
      { model | view <- Game
              , viewData <- {game=GameState.default model.dimensions} }

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
  viewData = {game=GameState.empty},

  hooks = [],

  dimensions = {width=1024, height=768},
  config = Configuration.default }
