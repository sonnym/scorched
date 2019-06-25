module Scorched.Model.Types exposing (..)

import Dict exposing (Dict)
import Time

-- Messages

type Msg
  = BasicMsg_ BasicMsg
  | KeyMsg_ KeyMsg
  | ControlMsg_ ControlMsg
  | MenuMsg_ MenuMsg
  | ModalMsg_ ModalMsg
  | NoOp

type BasicMsg
  = PermutationGenerated Permutation
  | Tick Time.Posix
  | UpdateView View

type KeyMsg
  = KeyDown String
  | KeyUp String
  | KeyPress String

type ControlMsg
  = ControlToggle Direction String
  | UpdateConfig Operation Specification

type MenuMsg
  = WorldGenerated World

type ModalMsg
  = PlaceHolder

-- Model Types

type alias Model =
  { view: View
  , time: Time.Posix
  , controls: Dict String Control
  , menuData: MainMenuData
  , permutation: Permutation
  , dimensions: Dimension
  , config: Configuration
  }

type View = MenuView Menu | ModalView Modal
type Menu = Main
type Modal = Landscape

type alias MainMenuData = { world: World }

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
  , toggle: (String -> Msg)
  }

type alias NumericSpec =
  { min: Int
  , max: Int
  , step: Int
  , invert: Direction
  , getter: (Configuration -> Int)
  , setter: (Configuration -> Int -> Configuration)
  , action: (Direction -> Control -> Msg)
  , toggle: (Direction -> String -> Msg)
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
