module Scorched.Model.Action exposing (..)

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
