module Scorched.View.Widget.Button where

import Signal (send)
import Text (leftAligned, fromString, monospace)

import Graphics.Input (customButton)

import Graphics.Collage (..)
import Graphics.Element (Element, size)

import Scorched.Action (Action, updates)

import Scorched.Model.World (Dimension)

import Scorched.View.Widget.BorderBox as BorderBox

build : Action -> String -> Dimension -> Element
build channelValue content ({width, height} as dimensions) =
  let
    text = fromString content
    formattedText = monospace text

    positionedText = move (6, -3) (toForm (size width height (leftAligned formattedText)))

    btnUp = collage width height [BorderBox.build dimensions False, positionedText]
    btnDown = collage width height [BorderBox.build dimensions True, positionedText]
  in
    customButton (send updates channelValue) btnUp btnUp btnDown
