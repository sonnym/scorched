module Scorched.View.Widget.Button where

import Signal
import Text

import Graphics.Input as Input
import Graphics.Element (..)
import Graphics.Collage (..)

import Scorched.Action as Action

import Scorched.Model.World (Dimension)

import Scorched.View.Widget.BorderBox as BorderBox

build : Action.Action -> String -> Dimension -> Element
build channelValue content ({width, height} as dimensions) =
  let
    text = moveY -4 (toForm (size width height (Text.centered (Text.fromString content))))

    btnUp = collage width height [BorderBox.build dimensions False, text]
    btnDown = collage width height [BorderBox.build dimensions True, text]
  in
    Input.customButton (Signal.send Action.updates channelValue) btnUp btnUp btnDown
