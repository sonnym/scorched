module Scorched.View.GamePlay exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg)

import Scorched.View.World as World
import Scorched.View.Component.BorderBox as BorderBox

build : Model -> Svg Msg
build model =
  Svg.g
    [ Attr.id "game-play" ]
    [ topBar model, world model ]

topBar : Model -> Svg Msg
topBar {dimensions} =
  Svg.g
    [ Attr.id "world"
    , Attr.transform "translate(2, 2)"
    ]
    [ BorderBox.build {width=dimensions.width, height=21} 2 False ]

world : Model -> Svg Msg
world model =
  Svg.g
    [ Attr.id "world"
    , Attr.transform "translate(3, 22)"
    ] [ World.build model.world]
