module Scorched.Model.Menu.Main exposing (controls)

import Scorched.Model.Types exposing (
  Msg(..),
  View(..),
  BasicMsg(..),
  ControlMsg(..),
  Specification(..),
  Modal(..),
  Direction(..),
  PlayerColor(..),
  Model,
  Control,
  IntegerControlSpec,
  ButtonControlSpec)

import Scorched.Model.Control exposing (toggle, action, dictFromList)

import Scorched.Model.Player exposing (firstPlayer)

import Scorched.Model.Sky as Sky
import Scorched.Model.World as World

controls : List Control
controls =
  [ Control "Start" 'S' {x=7, y=12}
    (Button (ButtonControlSpec {width=82, height=19} False (BasicMsg_ (UpdateView (ModalView (PlayerSelection firstPlayer)))) (toggle None)))

  , Control "Players" 'P' {x=8, y=40}
    (Integer (IntegerControlSpec 2 10 1 None (\config -> config.playerCount) (\config n -> { config | playerCount = n }) action toggle))

  , Control "Rounds" 'R' {x=8, y=70}
    (Integer (IntegerControlSpec 5 1000 5 None (\config -> config.roundCount) (\config n -> { config | roundCount = n }) action toggle))

  , Control "Sound…" 'o' {x=7, y=102}
    (Button (ButtonControlSpec {width=56, height=19} False NoOp (toggle None)))

  , Control "Hardware…" 'H' {x=7, y=132}
    (Button (ButtonControlSpec {width=78, height=19} False NoOp (toggle None)))

  , Control "Economics…" 'E' {x=7, y=162}
    (Button (ButtonControlSpec {width=84, height=19} False NoOp (toggle None)))

  , Control "Physics…" 'y' {x=7, y=192}
    (Button (ButtonControlSpec {width=70, height=19} False NoOp (toggle None)))

  , Control "Landscape…" 'L' {x=7, y=222}
    (Button (ButtonControlSpec {width=82, height=19} False (BasicMsg_ (UpdateView (ModalView Landscape))) (toggle None)))

  , Control "Play Options…" 't' {x=7, y=252}
    (Button (ButtonControlSpec {width=98, height=19} False NoOp (toggle None)))

  , Control "Weapons…" 'W' {x=7, y=282}
    (Button (ButtonControlSpec {width=68, height=19} False NoOp (toggle None)))
  ]
