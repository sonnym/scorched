module Scorched.View.Helper.Sky where

import List (map, length)

import Graphics.Collage (Form)
import Graphics.Collage as Collage

import Graphics.Element (flow, down, empty, size, color)

import Scorched.Model.Sky (Sky)
import Scorched.Model.World (Dimension)

toForm : Sky -> Dimension -> Form
toForm sky {width,height} =
  let
    bandHeight = ceiling ((toFloat height) / (toFloat (length sky)))
  in
    Collage.toForm (flow down
      (map (\band -> color band (size width bandHeight empty)) sky))
