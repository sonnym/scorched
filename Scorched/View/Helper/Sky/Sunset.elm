module Scorched.View.Helper.Sky.Sunset where

import Color (Color)
import List (indexedMap, length)

import Graphics.Collage (Form, groupTransform, moveY, filled, rect)

import Transform2D (translation)

import Scorched.Model.Geometry (Dimension)
import Scorched.Model.Sky.Sunset (Sunset)

toForm : Sunset -> Dimension -> Form
toForm sky {width,height} =
  let
    bandHeight = (toFloat height) / (toFloat (length sky))
    translationY = ((toFloat height) - bandHeight) / 2.0
  in
    groupTransform
      (translation 0.0 translationY)
      (indexedMap (\i color ->
        rect (toFloat width) bandHeight
          |> filled color
          |> moveY -(bandHeight * (toFloat i))) sky)
