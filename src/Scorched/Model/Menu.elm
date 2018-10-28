module Scorched.Model.Menu exposing (..)

import Dict exposing (Dict)

import Scorched.Action as Action exposing (Action(..), Direction(..))

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World exposing (World)

import Scorched.View.Component.Button exposing (Button)
import Scorched.View.Component.NumericField exposing (NumericField)

type alias MenuData =
  { buttons: Dict String Button
  , controls: Dict String NumericField
  , world: World
  }

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
      [ Button "Start" 'S' {width=82, height=19} {x=7, y=12} False Action.NoOp
      , Button "Sound…" 'o' {width=56, height=19} {x=7, y=102} False Action.NoOp
      , Button "Hardware…" 'H' {width=78, height=19} {x=7, y=132} False Action.NoOp
      , Button "Economics…" 'E' {width=84, height=19} {x=7, y=162} False Action.NoOp
      , Button "Physics…" 'y' {width=70, height=19} {x=7, y=192} False Action.NoOp
      , Button "Landscape…" 'L' {width=82, height=19} {x=7, y=222} False Action.NoOp
      , Button "Play Options…" 't' {width=98, height=19} {x=7, y=252} False Action.NoOp
      , Button "Weapons…" 'W' {width=68, height=19} {x=7, y=282} False Action.NoOp
      ]
    )

defaultControls : Dict String NumericField
defaultControls =
  Dict.fromList
    (List.map
      (\control -> (control.label, control))
      [ NumericField "Players" 'P' {x=8, y=40} None
      , NumericField "Rounds" 'R' {x=8, y=70} None
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

updateControls : Dict String NumericField -> String -> Direction -> Dict String NumericField
updateControls controls label direction =
  Dict.update label (updateControl direction) controls

updateControl : Direction -> Maybe NumericField -> Maybe NumericField
updateControl direction maybeControl =
  case maybeControl of
    Just control -> Just { control | invert = direction }
    Nothing -> Nothing

updateMenuWorld : MenuData -> Int -> MenuData
updateMenuWorld menuData n =
  let
    world = menuData.world
    newWorld = { world | sky = Sky.getSky n }
  in
    { menuData | world = newWorld }
