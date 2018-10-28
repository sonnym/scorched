module Scorched.Model.Menu exposing (..)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (..)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

default : MenuData
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

toggleButton : MenuData -> String -> MenuData
toggleButton menuData label =
  { menuData | buttons = updateButtons menuData.buttons label }

updateButtons : Dict String Button -> String -> Dict String Button
updateButtons buttons label = Dict.update label updateButton buttons

updateButton : Maybe Button -> Maybe Button
updateButton maybeButton =
  case maybeButton of
    Just button -> Just { button | inverted = not button.inverted }
    Nothing -> Nothing

toggleControl : MenuData -> String -> Direction -> MenuData
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

updateWorld : MenuData -> Int -> MenuData
updateWorld menuData n =
  let
    world = menuData.world
    newWorld = { world | sky = Sky.getSky n }
  in
    { menuData | world = newWorld }

updateTerrain : MenuData -> Terrain -> MenuData
updateTerrain menuData terrain =
  let
    world = menuData.world
    newWorld = { world | terrain = terrain }
  in
     { menuData | world = newWorld }

updateConfig : Configuration -> Operation -> ControlSpec -> Configuration
updateConfig config op spec =
  spec.setter config (guard (new op spec (spec.getter config)) spec)

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
