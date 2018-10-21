module Scorched.View.Component.KeyedLabel exposing (..)

import List exposing (head)

import Char
import String exposing (fromChar, length, indices, left, right)
-- import Text exposing (fromString, concat, color, justified, monospace)

import Html exposing (..)

-- import Scorched.View.Palette exposing (cyan)

build : String -> Char -> Html msg
build label key =
  span [] [ text label ]
{--
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
--}
