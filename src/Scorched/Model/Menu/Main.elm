module Scorched.Model.Menu.Main exposing (default, update, worldDimensions)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (
  Msg(..),
  View(..),
  MenuMsg(..),
  BasicMsg(..),
  Specification(..),
  Direction(..),
  Operation(..),
  Modal(..),
  Model,
  MainMenuData,
  Control,
  Configuration,
  NumericSpec,
  ButtonSpec,
  World,
  Dimension)

import Scorched.Model.Control as Control

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

default : MainMenuData
default =
  { controls = defaultControls
  , world = World.empty
  }

update : MenuMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    WorldGenerated world ->
      ({ model | menuData = updateWorld model.menuData world }, Cmd.none)

    ControlToggle direction label ->
      ({ model | menuData = toggleControl model.menuData label direction }, Cmd.none)

    UpdateConfig operation spec ->
      ({ model | config = updateModelConfig model.config operation spec }, Cmd.none)

defaultControls : Dict String Control
defaultControls =
  Dict.fromList
    (List.map
      (\control -> (control.label, control))
        [ Control "Start" 'S' {x=7, y=12}
          (Button (ButtonSpec {width=82, height=19} False NoOp (toggle None)))

        , Control "Players" 'P' {x=8, y=40}
          (Numeric (NumericSpec 2 10 1 None (\config -> config.playerCount) (\config n -> { config | playerCount = n }) action toggle))

        , Control "Rounds" 'R' {x=8, y=70}
          (Numeric (NumericSpec 5 1000 5 None (\config -> config.roundCount) (\config n -> { config | roundCount = n }) action toggle))

        , Control "Sound…" 'o' {x=7, y=102}
          (Button (ButtonSpec {width=56, height=19} False NoOp (toggle None)))

        , Control "Hardware…" 'H' {x=7, y=132}
          (Button (ButtonSpec {width=78, height=19} False NoOp (toggle None)))

        , Control "Economics…" 'E' {x=7, y=162}
          (Button (ButtonSpec {width=84, height=19} False NoOp (toggle None)))

        , Control "Physics…" 'y' {x=7, y=192}
          (Button (ButtonSpec {width=70, height=19} False NoOp (toggle None)))

        , Control "Landscape…" 'L' {x=7, y=222}
          (Button (ButtonSpec {width=82, height=19} False (BasicMsg_ (UpdateView (ModalView Landscape))) (toggle None)))

        , Control "Play Options…" 't' {x=7, y=252}
          (Button (ButtonSpec {width=98, height=19} False NoOp (toggle None)))

        , Control "Weapons…" 'W' {x=7, y=282}
          (Button (ButtonSpec {width=68, height=19} False NoOp (toggle None)))
        ]
    )

toggle : Direction -> String -> Msg
toggle direction label = MenuMsg_ (ControlToggle direction label)

action : Direction -> Control -> Msg
action direction ({spec} as control) =
  case spec of
    Numeric _ ->
      case direction of
        Up -> (MenuMsg_ (UpdateConfig Increment spec))
        Down -> (MenuMsg_ (UpdateConfig Decrement spec))
        None -> NoOp
    _ -> NoOp

toggleControl : MainMenuData -> String -> Direction -> MainMenuData
toggleControl menuData label direction =
  Control.toggleControl menuData label direction

updateWorld : MainMenuData -> World -> MainMenuData
updateWorld menuData world = { menuData | world = world }

updateModelConfig : Configuration -> Operation -> Specification -> Configuration
updateModelConfig config operation spec =
  case spec of
    Numeric numeric -> Control.updateConfig config operation numeric
    _ -> config

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
