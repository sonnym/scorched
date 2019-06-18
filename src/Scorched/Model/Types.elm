module Scorched.Model.Types exposing (..)

import Dict exposing (Dict)

import Time

import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.Model.Types.ModalMsg exposing (..)
import Scorched.Model.Types.View exposing (..)

type Operation = Increment | Decrement
type Direction = Up | Down | None

type Sky
  = Plain
  | Sunset
  | PitchBlack

type alias Terrain = List Int
type alias Permutation = List Int

type Msg
  = Basic BasicMsg
  | MainMenu MainMenuMsg
  | Modal ModalMsg
  | NoOp

type BasicMsg
  = PermutationGenerated Permutation
  | Tick Time.Posix
  | UpdateView View

type MainMenuMsg
  = World_ World
  | ControlToggle String Direction
  | KeyDown String
  | KeyUp String
  | KeyPress String
  | UpdateConfig Operation Specification

type alias Model =
  { view: View
  , time: Time.Posix
  , menuData: MainMenuData
  , permutation: Permutation
  , dimensions: Dimension
  , config: Configuration
  }

type alias Configuration =
  { playerCount: Int
  , roundCount: Int
  , noiseSettings: NoiseSettings
  }

type alias World =
  { sky: Sky
  , terrain: Terrain
  }

type alias MainMenuData =
  { controls: Dict String Control
  , world: World
  }

type Specification = Button ButtonSpec | Numeric NumericSpec | Type TypeSpec

type alias Control =
  { label: String
  , key: Char
  , offset: Offset
  , spec: Specification
  }

type alias ButtonSpec =
  { dimensions: Dimension
  , invert: Bool
  , action: Msg
  }

type alias NumericSpec =
  { min: Int
  , max: Int
  , step: Int
  , invert: Direction
  , getter: (Configuration -> Int)
  , setter: (Configuration -> Int -> Configuration)
  }

type alias TypeSpec =
  { invert: Direction
  , getter: (Configuration -> String)
  , setter: (Configuration -> String -> Configuration)
  }

type alias NoiseSettings =
  { octaves: Int
  , fallout: Float
  }
