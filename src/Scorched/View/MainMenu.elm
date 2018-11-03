module Scorched.View.MainMenu exposing (build)

import Dict exposing (Dict)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Msg(..))

import Scorched.Model.Types exposing (Model, Configuration, World, Button, Control)
import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.Model.MainMenu as MainMenu

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.ShadowText as ShadowText

import Scorched.View.Component.Button as Button
import Scorched.View.Component.Control as Control

import Scorched.View.World as World

build : Model -> Svg Msg
build ({dimensions, menuData, config} as model) =
  Svg.svg
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    , Attr.style "user-select: none; -moz-user-select: none;"
    ]
    (List.concat
      [ (background model)
      , (buttons (Dict.values menuData.buttons))
      , (controls config (Dict.values menuData.controls))
      , messages
      ]
    )

background : Model -> List (Svg Msg)
background {dimensions, menuData} =
  [ BorderBox.build dimensions 2 False
  , sample menuData.world
  ]

sample : World -> Svg Msg
sample sampleWorld =
  let
     world = World.build sampleWorld MainMenu.worldDimensions
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

buttons : List Button -> List (Svg Msg)
buttons definitions = List.map Button.build definitions

controls : Configuration -> List Control -> List (Svg Msg)
controls config definitions = List.map (Control.build config) definitions

messages : List (Svg msg)
messages =
  [ ShadowText.build "Scorched Earth" {x = 420, y = 48 }

  , Svg.text_
    [ Attr.transform "translate(472, 84)"
    , Attr.fill "white"
    ]
    [ Svg.text "The Mother of All Games" ]

  , Svg.text_
    [ Attr.transform "translate(504, 744)"
    , Attr.fill "black"
    ]
    [ Svg.text "Version 0.0.1" ]

  , Svg.text_
    [ Attr.transform "translate(408, 758)"
    , Attr.fill "black"
    ]
    [ Svg.text "Copyright (c) 1991-1995 Wendell Hicken" ]
  ]
