module Scorched.Model.MainMenu exposing (..)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (..)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

default : MainMenuData
default =
  { buttons = defaultButtons
  , controls = defaultControls
  , world = World.empty
  }

defaultButtons : Dict String Button
defaultButtons =
  Dict.fromList
    (List.map
      (\button -> (button.label, button))
      [ Button "Start" 'S' {width=82, height=19} {x=7, y=12} False NoOp
      , Button "Sound…" 'o' {width=56, height=19} {x=7, y=102} False NoOp
      , Button "Hardware…" 'H' {width=78, height=19} {x=7, y=132} False NoOp
      , Button "Economics…" 'E' {width=84, height=19} {x=7, y=162} False NoOp
      , Button "Physics…" 'y' {width=70, height=19} {x=7, y=192} False NoOp
      , Button "Landscape…" 'L' {width=82, height=19} {x=7, y=222} False NoOp
      , Button "Play Options…" 't' {width=98, height=19} {x=7, y=252} False NoOp
      , Button "Weapons…" 'W' {width=68, height=19} {x=7, y=282} False NoOp
      ]
    )

defaultControls : Dict String Control
defaultControls =
  Dict.fromList
    (List.map
      (\control -> (control.label, control))
      [ Control
        "Players" 'P' {x=8, y=40} None
        {min=2, max=10, step=1, getter=(\config -> config.playerCount ), setter=(\config n -> { config | playerCount = n })}

      , Control
        "Rounds" 'R' {x=8, y=70} None
        {min=5, max=1000, step=5, getter=(\config -> config.roundCount ), setter=(\config n -> { config | roundCount = n })}
      ]
    )

updateWorld : MainMenuData -> World -> MainMenuData
updateWorld menuData world = { menuData | world = world }

toggleButton : MainMenuData -> String -> MainMenuData
toggleButton menuData label =
  { menuData | buttons = updateButtons menuData.buttons label }

toggleButtonByKey : MainMenuData -> String -> MainMenuData
toggleButtonByKey menuData key =
  let
    maybeLabel = List.head (Dict.keys (findItem defaultButtons key))
  in
    case maybeLabel of
      Just label -> toggleButton menuData label
      Nothing -> menuData

updateButtons : Dict String Button -> String -> Dict String Button
updateButtons buttons label = Dict.update label updateButton buttons

updateButton : Maybe Button -> Maybe Button
updateButton maybeButton =
  case maybeButton of
    Just button -> Just { button | inverted = not button.inverted }
    Nothing -> Nothing

toggleControl : MainMenuData -> String -> Direction -> MainMenuData
toggleControl menuData label direction =
  { menuData | controls = updateControls menuData.controls label direction }

updateControls : Dict String Control -> String -> Direction -> Dict String Control
updateControls controls label direction =
  Dict.update label (updateControl direction) controls

updateControl : Direction -> Maybe Control -> Maybe Control
updateControl direction maybeControl =
  case maybeControl of
    Just control -> Just { control | invert = direction }
    Nothing -> Nothing

updateConfig : Configuration -> Operation -> ControlSpec -> Configuration
updateConfig config op spec =
  spec.setter config (guard (new op spec (spec.getter config)) spec)

handleKeyPress : Configuration -> String -> Configuration
handleKeyPress config key =
  let
    maybeControl = List.head (Dict.values (findItem defaultControls key))
  in
    case maybeControl of
      Just control -> updateConfig config Increment control.spec
      Nothing -> config

findItem : Dict String { a | key: Char } -> String -> Dict String { a | key: Char }
findItem dict key = Dict.filter (\_ item -> String.fromChar item.key == key) dict

guard : Int -> ControlSpec -> Int
guard value {min, max} =
  if value > max then
    min
  else if value < min then
    max
  else
    value

new : Operation -> ControlSpec -> Int -> Int
new operation {step} value =
  case operation of
    Increment -> value + step
    Decrement -> value - step

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
