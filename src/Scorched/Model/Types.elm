module Scorched.Model.Types exposing (..)

import Dict exposing (Dict)
import Time

-- Messages

type Msg
  = Basic BasicMsg
  | MainMenu MainMenuMsg
  | Key KeyMsg
  | Modal ModalMsg
  | NoOp

type BasicMsg
  = PermutationGenerated Permutation
  | Tick Time.Posix
  | UpdateView View

type KeyMsg
  = KeyDown String
  | KeyUp String
  | KeyPress String

type MainMenuMsg
  = World_ World
  | ControlToggle Direction String
  | UpdateConfig Operation Specification

type ModalMsg
  = PlaceHolder

-- Model Types

type alias Model =
  { view: View
  , time: Time.Posix
  , menuData: MainMenuData
  , permutation: Permutation
  , dimensions: Dimension
  , config: Configuration
  }

type View = MenuView Menu_ | ModalView Modal_
type Menu_ = Main
type Modal_ = Landscape

type alias MainMenuData =
  { controls: Dict String Control
  , world: World
  }

type alias Permutation = List Int

type alias Configuration =
  { playerCount: Int
  , roundCount: Int
  , noiseSettings: NoiseSettings
  }

-- Core Types

type Operation = Increment | Decrement
type Direction = Up | Down | None

type Sky
  = Plain
  | Sunset
  | PitchBlack

type alias Terrain = List Int

type alias World =
  { sky: Sky
  , terrain: Terrain
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
  , toggle: String -> Msg
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

-- Geometric Types

type alias Dimension = {width: Int, height: Int}
type alias Point = {x: Int, y: Int}
type alias Offset = Point
