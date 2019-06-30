module Scorched.Model.Modal exposing (controls)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (Modal(..), Control)

import Scorched.Model.Control as Control

import Scorched.Model.Modal.Landscape as Landscape

controls : Modal -> Dict String Control
controls modal =
  case modal of
    Landscape -> Control.dictFromList Landscape.controls
    _ -> Dict.empty
