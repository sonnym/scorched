module Scorched.View.Menu.Main exposing (build)

import Dict exposing (Dict)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Msg(..), View(..), Model, Configuration, World, Control)

import Scorched.Model.Geometry exposing (Dimension, Offset)

import Scorched.Model.Menu.Main as MainMenu

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.ShadowText as ShadowText

import Scorched.View.Component.Control as Control

import Scorched.View.World as World

build : Model -> Svg Msg
build ({view, dimensions, menuData, config} as model) =
  Svg.g
    [ Attr.id "menu-main" ]
    [ background model
    , controls config (isModalOpen view) (Dict.values menuData.controls)
    , titleText
    , bottomText
    ]

background : Model -> Svg Msg
background {dimensions, menuData} =
  Svg.g
    [ Attr.id "background" ]
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
      [ Attr.id "menu-main--world", Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

controls : Configuration -> Bool -> List Control -> Svg Msg
controls config disabled definitions =
  Svg.g
    [ Attr.id "controls" ]
    (List.map (Control.build config disabled) definitions)

titleText : Svg msg
titleText =
  Svg.g
    [ Attr.id "titletext" ]
    [ ShadowText.build "Scorched Earth" {x = 420, y = 48 }
    , Svg.text_
      [ Attr.transform "translate(472, 84)"
      , Attr.fill "white"
      ]
      [ Svg.text "The Mother of All Games" ]
    ]

bottomText : Svg msg
bottomText =
  Svg.g
    [ Attr.id "bottomtext" ]
    [ Svg.text_
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

isModalOpen : View -> Bool
isModalOpen view =
  case view of
    MenuView _ -> False
    ModalView _ -> True
