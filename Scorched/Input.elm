module Scorched.Input where

import Signal (Signal, merge, map, sampleOn, constant)
import Time (every, millisecond)

import Keyboard (KeyCode, lastPressed)

type Input = Nothing | Just KeyCode

keypress : Signal Input
keypress = merge (map Just lastPressed) (sampleOn (every millisecond) (constant Nothing))
