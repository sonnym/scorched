module Scorched.View.Helper.Sky.Sunset where

import Color exposing (Color)

import Graphics.Collage exposing (Form, groupTransform, moveY, filled, rect)

import Transform2D exposing (translation)

import Scorched.Model.Geometry exposing (Dimension)
import Scorched.Model.Sky.Sunset exposing (Sunset)

toForm : Sunset -> Dimension -> Form
toForm sky {width,height} =
  let
    bandHeight = (toFloat height) / (toFloat (List.length sky))
    translationY = ((toFloat height) - bandHeight) / 2.0
  in
    groupTransform
      (translation 0.0 translationY)
      (List.indexedMap (\i color ->
        rect (toFloat width) bandHeight
          |> filled color
          |> moveY -(bandHeight * (toFloat i))) sky)
