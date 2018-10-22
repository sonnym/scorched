module Scorched.View.Component.Button exposing (..)

-- import Text exposing (leftAligned, fromString, monospace)
import Svg exposing(..)
import Svg.Attributes as Attr

import Scorched.Action exposing (Action, updates)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Action -> String -> Char -> Dimension -> Svg msg
build action content key ({width, height}) =
  g [ ]
  [ BorderBox.build width height 2 False
  , text_ [ Attr.x "12", Attr.y "17.5" ] [ text content ]
  ]
{--
  let
    label = KeyedLabel.build content key

    btnUp = collage width height [BorderBox.build dimensions 2 False, positionedText]
    btnDown = collage width height [BorderBox.build dimensions 2 True, positionedText]
  in
    customButton (send updates action) btnUp btnUp btnDown
--}
