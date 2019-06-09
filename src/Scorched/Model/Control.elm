module Scorched.Model.Control exposing (
  handleKeyPress,
  toggleControl,
  toggleControlByKey,
  updateConfig,
  updateControls)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (..)

import Scorched.Model.Helper as Helper

handleKeyPress : Dict String Control -> Configuration -> String -> Cmd Msg
handleKeyPress controls config key =
  let
    maybeControl = List.head (Dict.values (findItem controls key))
  in
    case maybeControl of
      Just control ->
        case control.spec of
          Button buttonSpec -> Helper.send buttonSpec.action
          Numeric _ -> Helper.send (UpdateConfig Increment control.spec)
          _ -> Cmd.none
      Nothing -> Cmd.none

toggleControlByKey : Dict String Control -> MainMenuData -> String -> MainMenuData
toggleControlByKey controls menuData key =
  let
    maybeLabel = List.head (Dict.keys (findItem controls key))
  in
    case maybeLabel of
      Just label -> toggleControl menuData label Up
      Nothing -> menuData

toggleControl : MainMenuData -> String -> Direction -> MainMenuData
toggleControl menuData label direction =
    { menuData | controls = updateControls menuData.controls label direction }

updateConfig : Configuration -> Operation -> NumericSpec -> Configuration
updateConfig config op spec =
  spec.setter config (guard (new op spec (spec.getter config)) spec)

updateControls : Dict String Control -> String -> Direction -> Dict String Control
updateControls controls label direction =
  Dict.update label (updateControl direction) controls

updateControl : Direction -> Maybe Control -> Maybe Control
updateControl direction maybeControl =
  case maybeControl of
    Just ({spec} as control) ->
      case spec of
        Button button ->
          let newSpec = { button | invert = not button.invert }
          in Just { control | spec = Button newSpec }
        Numeric numeric ->
          let newSpec = { numeric | invert = (if numeric.invert == direction then None else direction) }
          in Just { control | spec = Numeric newSpec }
        _ -> Nothing
    Nothing -> Nothing

new : Operation -> NumericSpec -> Int -> Int
new operation {step} value =
  case operation of
    Increment -> value + step
    Decrement -> value - step

findItem : Dict String { a | key: Char } -> String -> Dict String { a | key: Char }
findItem dict key = Dict.filter (\_ item -> String.fromChar item.key == key) dict

guard : Int -> NumericSpec -> Int
guard value {min, max} =
  if value > max then
    min
  else if value < min then
    max
  else
    value
