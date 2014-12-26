module Scorched.View.Widget.KeyedLabel where

import Signal (Message)
import List (head)

import Char
import String (fromChar, length, indices, left, right)
import Text (fromString, concat, color, justified, monospace)

import Graphics.Element (Element)

import Scorched.View.Palette (cyan)

build : String -> Char -> Element
build label key =
  let
    location = head (indices (fromChar key) label)
    prefix = left location label
    suffix = right ((length label) - location - 1) label
  in
    justified (monospace (concat
      [ fromString prefix
      , color cyan (fromString (fromChar key))
      , fromString suffix
      ]))

