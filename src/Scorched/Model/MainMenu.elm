module Scorched.Model.MainMenu exposing (
  default,
  handleKeyPress,
  toggleControl,
  toggleControlByKey,
  updateModelConfig,
  updateWorld,
  worldDimensions)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (..)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Control as Control

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

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

        , Control "Players" 'P' {x=8, y=40}
          (Numeric (NumericSpec 2 10 1 None (\config -> config.playerCount) (\config n -> { config | playerCount = n })))

        , Control "Rounds" 'R' {x=8, y=70}
          (Numeric (NumericSpec 5 1000 5 None (\config -> config.roundCount) (\config n -> { config | roundCount = n })))

        , Control "Sound…" 'o' {x=7, y=102} (Button (ButtonSpec {width=56, height=19} False NoOp))
        , Control "Hardware…" 'H' {x=7, y=132} (Button (ButtonSpec {width=78, height=19} False NoOp))
        , Control "Economics…" 'E' {x=7, y=162} (Button (ButtonSpec {width=84, height=19} False NoOp))
        , Control "Physics…" 'y' {x=7, y=192} (Button (ButtonSpec {width=70, height=19} False NoOp))
        , Control "Landscape…" 'L' {x=7, y=222} (Button (ButtonSpec {width=82, height=19} False (UpdateView (Modal Landscape))))
        , Control "Play Options…" 't' {x=7, y=252} (Button (ButtonSpec {width=98, height=19} False NoOp))
        , Control "Weapons…" 'W' {x=7, y=282} (Button (ButtonSpec {width=68, height=19} False NoOp))
        ]
    )

handleKeyPress : Configuration -> String -> Cmd Msg
handleKeyPress configuration label =
  (Control.handleKeyPress defaultControls) configuration label

toggleControl : MainMenuData -> String -> Direction -> MainMenuData
toggleControl menuData label direction =
  Control.toggleControl menuData label direction

toggleControlByKey : MainMenuData -> String -> MainMenuData
toggleControlByKey menuData key =
  (Control.toggleControlByKey defaultControls) menuData key

updateWorld : MainMenuData -> World -> MainMenuData
updateWorld menuData world = { menuData | world = world }

updateModelConfig : Configuration -> Operation -> Specification -> Configuration
updateModelConfig config operation spec =
  case spec of
    Numeric numeric -> Control.updateConfig config operation numeric
    _ -> config

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
