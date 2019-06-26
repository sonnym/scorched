module Scorched.Model.Control.Numeric exposing (updateConfig)

import Scorched.Model.Types exposing (Operation(..), Configuration, Control, NumericSpec)

updateConfig : Configuration -> Operation -> NumericSpec -> Configuration
updateConfig config op {getter, setter, step, min, max} =
  setter config (guard (new op step (getter config)) min max)

new : Operation -> Int -> Int -> Int
new operation step value =
  case operation of
    Increment -> value + step
    Decrement -> value - step

guard : Int -> Int -> Int -> Int
guard value min max =
  if value > max then
    min
  else if value < min then
    max
  else
    value
