module Scorched.View.Menu exposing (..)

import Dict exposing (Dict)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.Action as Action exposing (Action(..))

import Scorched.Model exposing (Model)
import Scorched.Model.Geometry exposing (Dimension, Offset)
import Scorched.Model.World exposing (World)

import Scorched.Model.Menu as Menu

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.ShadowText as ShadowText

import Scorched.View.Component.Button as Button exposing (Button)
import Scorched.View.Component.NumericField as NumericField exposing (NumericField)

import Scorched.View.World as WorldView

render : Model -> Svg Action
render ({dimensions, menuData} as model) =
  Svg.svg
    [ Attr.width (String.fromInt dimensions.width)
    , Attr.height (String.fromInt dimensions.height)
    , Attr.fontFamily "monospace"
    , Attr.style "user-select: none"
    ]
    (List.concat
      [ (background model)
      , (buttons (Dict.values menuData.buttons))
      , (controls (Dict.values menuData.controls))
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
     world = WorldView.build sampleWorld worldDimensions
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

buttons : List Button -> List (Svg Action)
buttons definitions = List.map Button.build definitions

controls : List NumericField -> List (Svg Action)
controls definitions = List.map NumericField.build definitions

worldDimensions : Dimension
worldDimensions = {width=906, height=724}
