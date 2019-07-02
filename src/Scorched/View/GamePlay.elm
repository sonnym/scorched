module Scorched.View.GamePlay exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg)

import Scorched.View.Component.BorderBox as BorderBox

build : Model -> Svg Msg
build model =
  Svg.g
    [ Attr.id "game-play" ]
    [ topBar model ]

topBar : Model -> Svg Msg
topBar {dimensions} =
  BorderBox.build {width=dimensions.width, height=21} 2 False
