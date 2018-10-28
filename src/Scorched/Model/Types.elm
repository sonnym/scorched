module Scorched.Model.Types exposing (..)

import Dict exposing (Dict)

import Scorched.Model.Action exposing (Action, Direction, Sky)
import Scorched.Model.Geometry exposing (Dimension, Offset)

type View = Menu -- | Game

type alias Model =
  { view: View
  , menuData: MenuData
  -- , viewData: { game: GameState }
  , dimensions: Dimension
  , config: Configuration
  }

type alias Configuration =
  { playerCount: Int
  , roundCount: Int
  }

type alias World =
  { sky: Sky }
  -- , terrain: Terrain

type alias MenuData =
  { buttons: Dict String Button
  , controls: Dict String Control
  , world: World
  }

type alias Button =
  { label: String
  , key: Char
  , dimensions: Dimension
  , offset: Offset
  , inverted: Bool
  , action: Action
  }

type alias Control =
  { label: String
  , key: Char
  , offset: Offset
  , invert: Direction
  , value: (Configuration -> Int)
  }
