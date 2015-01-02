module Scorched.View.Helper.Sky.Sunset where

import Color (Color)
import List (map, length)

import Graphics.Collage as Collage
import Graphics.Collage (Form, groupTransform)

import Transform2D (scaleY)

import Graphics.Element (flow, down, empty, size, color, heightOf)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.Sky (Sky(Sunset))

toForm : List Color -> Dimension -> Form
toForm sky {width,height} =
  let
    bandHeight = ceiling ((toFloat height) / (toFloat (length sky)))
    elem = flow down (map (\band -> color band (size width bandHeight empty)) sky)
  in
    groupTransform
      (scaleY ((toFloat height) / (toFloat (heightOf elem))))
      [ Collage.toForm elem ]
