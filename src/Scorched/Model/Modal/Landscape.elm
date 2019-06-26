module Scorched.Model.Modal.Landscape exposing (controls)

import Scorched.Model.Types exposing (Control, Direction(..), Specification(..), TypeSpec)

import Scorched.Model.Control exposing (action, toggle)

controls : List Control
controls =
  [ Control "Sky" 'S' {x=7, y=12} (Type (TypeSpec None (\_ -> "Random") (\a _ -> a) action toggle)) ]
