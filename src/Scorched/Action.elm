module Scorched.Action exposing (..)

type Sky
  = Plain
  | Sunset
  | PitchBlack

type Action
  = MenuSky Int
  | ButtonToggle String
  | NoOp
  -- | Initialize
  -- | Start
  -- | Configuration Configuration.Action
