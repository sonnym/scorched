module Scorched.Model.Types exposing (..)

import Dict exposing (Dict)

import Scorched.Model.Geometry exposing (Dimension, Offset)

type View = Menu -- | Game

type Operation = Increment | Decrement
type Direction = Up | Down | None

type Sky
  = Plain
  | Sunset
  | PitchBlack

type Action
  = MenuSky Int
  | ButtonToggle String
  | ControlToggle String Direction
  | NoOp
  -- | Initialize
  -- | Start
  -- | Configuration Configuration.Action

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
