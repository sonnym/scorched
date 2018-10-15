module Scorched.Input exposing (..)

import Signal exposing (Signal, map)
import Keyboard exposing (KeyCode, keysDown)

type alias Input = List KeyCode

keypress : Signal Input
keypress = keysDown
