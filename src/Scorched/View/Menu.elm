module Scorched.View.Menu exposing (..)

import Dict exposing (Dict)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Action(..))

import Scorched.Model.Types exposing (Model, Configuration, World, Button, Control)
import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.Model.Menu as Menu

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.ShadowText as ShadowText

import Scorched.View.Component.Button as Button
import Scorched.View.Component.Control as Control

import Scorched.View.World as World

render : Model -> Svg Action
render ({dimensions, menuData, config} as model) =
  Svg.svg
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    , Attr.style "user-select: none"
    ]
    (List.concat
      [ (background model)
      , (buttons (Dict.values menuData.buttons))
      , (controls config (Dict.values menuData.controls))
      ]
    )

background : Model -> List (Svg Action)
background {dimensions, menuData} =
  [ BorderBox.build dimensions 2 False
  , sample menuData.world
  , ShadowText.build "Scorched Earth" {x = 420, y = 48 }
  ]

sample : World -> Svg Action
sample sampleWorld =
  let
     world = World.build sampleWorld Menu.worldDimensions
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

buttons : List Button -> List (Svg Action)
buttons definitions = List.map Button.build definitions

controls : Configuration -> List Control -> List (Svg Action)
controls config definitions = List.map (Control.build config) definitions
