module Scorched.Model.Control.Numeric exposing (updateConfig)

import Scorched.Model.Types exposing (Operation(..), Configuration, Control, NumericSpec)

updateConfig : Configuration -> Operation -> NumericSpec -> Configuration
updateConfig config op ({getter, setter} as spec) =
  setter config (guard (new op spec (getter config)) spec)

new : Operation -> NumericSpec -> Int -> Int
new operation {step} value =
  case operation of
    Increment -> value + step
    Decrement -> value - step

guard : Int -> NumericSpec -> Int
guard value {min, max} =
  if value > max then
    min
  else if value < min then
    max
  else
    value
