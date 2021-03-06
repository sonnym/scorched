module Scorched.Model.Types exposing (..)

import Dict exposing (Dict)
import Time

import Scorched.View.Palette exposing (Color)

-- Messages

type Msg
  = BasicMsg_ BasicMsg
  | KeyMsg_ KeyMsg
  | ControlMsg_ ControlMsg
  | GameMsg_ GameMsg
  | NoOp

type BasicMsg
  = PermutationGenerated Permutation
  | SetVersion String
  | WorldGenerated World
  | Tick Time.Posix
  | UpdateView View

type KeyMsg
  = KeyDown String
  | KeyUp String
  | KeyPress String

type ControlMsg
  = ControlToggle Direction String
  | UpdateConfig Operation Specification

type GameMsg
  = Initialize

-- Model Types

type alias Model =
  { version: String
  , view: View
  , time: Time.Posix
  , ticks: Int
  , controls: Dict String Control
  , permutation: Permutation
  , dimensions: Dimension
  , config: Config
  , world: World
  }

type View = MenuView Menu | ModalView Modal | GamePlay
type Menu = Main
type Modal = Landscape | PlayerSelection PlayerColor

type alias Permutation = List Int

-- Core Types

type Operation = Increment | Decrement
type Direction = Up | Down | None

type Sky
  = Random
  | Plain
  | Sunset
  | PitchBlack

type PlayerColor
  = Red
  | Green
  | Purple
  | Yellow
  | Aqua
  | Fuchsia
  | White
  | Orange
  | Mint
  | Blue

type alias Terrain =
  { altitudes: List Int
  , color: Color
  }

type alias World =
  { sky: Sky
  , terrain: Terrain
  , dimensions: Dimension
  , players: List Player
  }

type alias Player =
  { color: PlayerColor
  , position: Point
  }

type Specification
  = Button ButtonControlSpec
  | Integer IntegerControlSpec
  | String StringControlSpec

type alias Control =
  { label: String
  , key: Char
  , offset: Offset
  , spec: Specification
  }

type alias ButtonControlSpec =
  { dimensions: Dimension
  , invert: Bool
  , action: Msg
  , toggle: (String -> Msg)
  }

type alias IntegerControlSpec =
  { min: Int
  , max: Int
  , step: Int
  , invert: Direction
  , getter: (Config -> Int)
  , setter: (Config -> Int -> Config)
  , action: (Direction -> Control -> Msg)
  , toggle: (Direction -> String -> Msg)
  }

type alias StringControlSpec =
  { options: List String
  , invert: Direction
  , getter: (Config -> String)
  , setter: (Config -> String -> Config)
  , action: (Direction -> Control -> Msg)
  , toggle: (Direction -> String -> Msg)
  }

-- Config Types

type alias Config =
  { playerCount: Int
  , roundCount: Int
  , worldConfig: WorldConfig
  }

type alias WorldConfig =
  { sky: Sky
  , dimensions: Dimension
  , bumpiness: Int
  , slopes: Int
  }

-- Geometric Types

type alias Dimension = {width: Int, height: Int}
type alias Point = {x: Int, y: Int}
type alias Offset = Point
