module Scorched.View.Widget.Button where

import Signal
import Text

import Graphics.Input as Input
import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Model.World (Dimension)

import Scorched.View.Widget.BorderBox as BorderBox

build : Signal.Channel () -> String -> Dimension -> Element
build channel content ({width, height} as dimensions) =
  let
    btn = collage width height
      [ BorderBox.build dimensions
      , toForm (size width height (Text.centered (Text.fromString content)))
      ]
  in
    Input.customButton (Signal.send channel ()) btn btn btn
