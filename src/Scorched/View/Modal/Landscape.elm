module Scorched.View.Modal.Landscape exposing (build)

import Dict

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg)

import Scorched.Model.Modal.Landscape as Landscape

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.Control as Control

build : Model -> Svg Msg
build {controls, config} =
  Svg.g
    [ Attr.transform "translate(410, 345)" ]
    [ BorderBox.build {width=300, height=240} 2 False
    , Svg.g
      [ Attr.id "landscape-controls" ]
      (List.map (Control.build config False) (Dict.values controls))
    ]
