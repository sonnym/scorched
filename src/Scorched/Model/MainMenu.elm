module Scorched.Model.MainMenu exposing (..)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (..)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

import Scorched.Model.Helper as Helper

default : MainMenuData
default =
  { controls = defaultControls
  , world = World.empty
  }

defaultControls : Dict String Control
defaultControls =
  Dict.fromList
    (List.map
      (\control -> (control.label, control))
        [ Control "Start" 'S' {x=7, y=12} (Button (ButtonSpec {width=82, height=19} False NoOp))
        , Control "Sound…" 'o' {x=7, y=102} (Button (ButtonSpec {width=56, height=19} False NoOp))
        , Control "Hardware…" 'H' {x=7, y=132} (Button (ButtonSpec {width=78, height=19} False NoOp))
        , Control "Economics…" 'E' {x=7, y=162} (Button (ButtonSpec {width=84, height=19} False NoOp))
        , Control "Physics…" 'y' {x=7, y=192} (Button (ButtonSpec {width=70, height=19} False NoOp))
        , Control "Landscape…" 'L' {x=7, y=222} (Button (ButtonSpec {width=82, height=19} False (UpdateView (SubMenu Landscape))))
        , Control "Play Options…" 't' {x=7, y=252} (Button (ButtonSpec {width=98, height=19} False NoOp))
        , Control "Weapons…" 'W' {x=7, y=282} (Button (ButtonSpec {width=68, height=19} False NoOp))

        , Control "Players" 'P' {x=8, y=40}
          (Numeric (NumericSpec 2 10 1 None (\config -> config.playerCount) (\config n -> { config | playerCount = n })))

        , Control "Rounds" 'R' {x=8, y=70}
          (Numeric (NumericSpec 5 1000 5 None (\config -> config.roundCount) (\config n -> { config | roundCount = n })))
        ]
    )

updateWorld : MainMenuData -> World -> MainMenuData
updateWorld menuData world = { menuData | world = world }

toggleControlByKey : MainMenuData -> String -> MainMenuData
toggleControlByKey menuData key =
  let
    maybeLabel = List.head (Dict.keys (findItem defaultControls key))
  in
    case maybeLabel of
      Just label -> toggleControl menuData label Up
      Nothing -> menuData

toggleControl : MainMenuData -> String -> Direction -> MainMenuData
toggleControl menuData label direction =
    { menuData | controls = updateControls menuData.controls label direction }

updateControls : Dict String Control -> String -> Direction -> Dict String Control
updateControls controls label direction =
  Dict.update label (updateControl direction) controls

updateModelConfig : Configuration -> Operation -> Specification -> Configuration
updateModelConfig config operation spec =
  case spec of
    Numeric numeric -> updateConfig config operation numeric
    _ -> config

updateConfig : Configuration -> Operation -> NumericSpec -> Configuration
updateConfig config op spec =
  spec.setter config (guard (new op spec (spec.getter config)) spec)

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
    Nothing -> Nothing

handleKeyPress : Configuration -> String -> Cmd Msg
handleKeyPress config key =
  let
    maybeControl = List.head (Dict.values (findItem defaultControls key))
  in
    case maybeControl of
      Just control ->
        case control.spec of
          Button buttonSpec -> Helper.send buttonSpec.action
          Numeric _ -> Helper.send (UpdateConfig Increment control.spec)
      Nothing -> Cmd.none

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

new : Operation -> NumericSpec -> Int -> Int
new operation {step} value =
  case operation of
    Increment -> value + step
    Decrement -> value - step

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
