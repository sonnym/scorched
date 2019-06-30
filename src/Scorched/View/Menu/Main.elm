module Scorched.View.Menu.Main exposing (build)

import Dict exposing (Dict)

import Svg exposing(Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (
  Msg(..),
  View(..),
  Model,
  Config,
  World,
  Control,
  Dimension,
  Offset)

import Scorched.Model.Menu.Main as MainMenu

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.ShadowText as ShadowText

import Scorched.View.Component.Control as Control

import Scorched.View.World as World

build : Model -> Svg Msg
build ({view, dimensions, config} as model) =
  let
    modalOpen = isModalOpen view
    visibleControls = if modalOpen then MainMenu.controls else (Dict.values model.controls)
  in
    Svg.g
      [ Attr.id "menu-main" ]
      [ background model
      , controls config modalOpen visibleControls
      , titleText
      , bottomText
      ]

background : Model -> Svg Msg
background {dimensions, world} =
  Svg.g
    [ Attr.id "background" ]
    [ BorderBox.build dimensions 2 False
    , sample world
    ]

sample : World -> Svg Msg
sample sampleWorld =
  let
     world = World.build sampleWorld
     outline = BorderBox.build {width=908, height=726} 1 True
  in
    Svg.g
      [ Attr.id "menu-main--world", Attr.transform ("translate(109, 6)") ]
      [ outline, world ]

controls : Config -> Bool -> List Control -> Svg Msg
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
      [ Attr.transform "translate(300, 758)"
      , Attr.fill "black"
      ]
      [ Svg.text "Copyright (c) 1991-1995 "
      , Svg.a
          [ Attr.xlinkHref "http://www.whicken.com/", Attr.fill "#0000ff" ]
          [ Svg.text "Wendell Hicken" ]
      , Svg.text "; Copied 2019 "
      , Svg.a
          [ Attr.xlinkHref "https://sonnym.github.io/", Attr.fill "#0000ff" ]
          [ Svg.text "Sonny Michaud" ]
      ]
    ]

isModalOpen : View -> Bool
isModalOpen view =
  case view of
    ModalView _ -> True
    _ -> False
