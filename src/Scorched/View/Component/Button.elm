module Scorched.View.Component.Button exposing (..)

-- import Text exposing (leftAligned, fromString, monospace)
import Svg exposing(..)

import Scorched.Action exposing (Action, updates)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.View.Component.BorderBox as BorderBox
import Scorched.View.Component.KeyedLabel as KeyedLabel

build : Action -> String -> Char -> Dimension -> Svg msg
build action content key ({width, height} as dimensions) =
  text_ [] [ text content ]
{--
  let
    label = KeyedLabel.build content key
    positionedText = move (6, -3) (toForm (size width height label))

    btnUp = collage width height [BorderBox.build dimensions 2 False, positionedText]
    btnDown = collage width height [BorderBox.build dimensions 2 True, positionedText]
  in
    customButton (send updates action) btnUp btnUp btnDown
--}
