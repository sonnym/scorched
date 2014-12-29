module Scorched.Input where

import Signal (Signal, map)
import Keyboard (KeyCode, keysDown)

type alias Input = List KeyCode

keypress : Signal Input
keypress = keysDown
