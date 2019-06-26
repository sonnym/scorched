module Scorched.Model.Menu.Main exposing (default, update, controls, worldDimensions)

import Scorched.Model.Types exposing (
  Msg(..),
  View(..),
  MenuMsg(..),
  BasicMsg(..),
  ControlMsg(..),
  Specification(..),
  Modal(..),
  Direction(..),
  Model,
  MainMenuData,
  Control,
  NumericSpec,
  ButtonSpec,
  World,
  Dimension)

import Scorched.Model.Control exposing (toggle, action, dictFromList)

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

default : MainMenuData
default = { world = World.empty }

update : MenuMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    WorldGenerated world ->
      ({ model | menuData = updateWorld model.menuData world }, Cmd.none)

controls : List Control
controls =
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

updateWorld : MainMenuData -> World -> MainMenuData
updateWorld menuData world = { menuData | world = world }

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
