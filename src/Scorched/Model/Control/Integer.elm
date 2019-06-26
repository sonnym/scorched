module Scorched.Model.Control.Integer exposing (updateConfig)

import Scorched.Model.Types exposing (Operation(..), Config, Control, IntegerControlSpec)

updateConfig : Config -> Operation -> IntegerControlSpec -> Config
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
