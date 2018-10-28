module Scorched.Model.Types exposing (..)

import Scorched.Model.Action exposing (Action, Direction)
import Scorched.Model.Geometry exposing (Dimension, Offset)

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
  }
