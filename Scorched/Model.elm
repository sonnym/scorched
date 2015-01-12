module Scorched.Model where

import Scorched.Action (Hook)
import Scorched.Model.Geometry (Dimension)

import Scorched.Model.GameState (GameState)
import Scorched.Model.GameState as GameState

import Scorched.Model.Configuration (Configuration)
import Scorched.Model.Configuration as Configuration

type View = Menu | Game

type alias Model = {
  view: View,
  viewData: { game: GameState },
  hooks: List Hook,
  dimensions: Dimension,
  config: Configuration
}

default : Model
default = {
  view = Menu,
  viewData = {game=GameState.empty},

  hooks = [],

  dimensions = {width=1024, height=768},
  config = Configuration.default }
