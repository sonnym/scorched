module Scorched.Model exposing (..)

-- import Scorched.Action exposing (Hook)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.GameState as GameState exposing (GameState)
import Scorched.Model.Configuration as Configuration exposing (Configuration)

type View = Menu | Game

type alias Model =
  { view: View
  , viewData: { game: GameState }
--   , hooks: List Hook
  , dimensions: Dimension
  , config: Configuration
  }

default : Model
default =
  { view = Menu
  , viewData = {game=GameState.empty}

-- ,  hooks = []

  , dimensions = {width=1024, height=768}
  , config = Configuration.default
  }
