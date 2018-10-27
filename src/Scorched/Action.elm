module Scorched.Action exposing (..)

type Sky
  = Plain
  | Sunset
  | PitchBlack

type Action
  = MenuSky Int
  | ButtonUp String
  | ButtonDown String
  | NoOp
  -- | Initialize
  -- | Start
  -- | Configuration Configuration.Action
