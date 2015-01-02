module Scorched.View.Helper.Sky where

import List (map, length)

import Graphics.Collage (Form, groupTransform)
import Graphics.Collage as Collage

import Graphics.Element as Element
import Graphics.Element (flow, down, empty, size, color, heightOf)

import Transform2D (scaleY)

import Scorched.Model.Geometry (Dimension)
import Scorched.Model.Sky (Sky)

toForm : Sky -> Dimension -> Form
toForm sky {width,height} =
  let
    bandHeight = ceiling ((toFloat height) / (toFloat (length sky)))
    elem = flow down (map (\band -> color band (size width bandHeight empty)) sky)
  in
    groupTransform
      (scaleY ((toFloat height) / (toFloat (heightOf elem))))
      [ Collage.toForm elem ]
