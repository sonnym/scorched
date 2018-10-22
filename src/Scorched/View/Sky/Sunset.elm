module Scorched.View.Helper.Sky.Sunset exposing (..)

import Svg exposing (Svg)

import Scorched.Model.Geometry exposing (Dimension)
import Scorched.Model.Sky.Sunset exposing (Sunset)

toForm : Sunset -> Dimension -> Svg msg
toForm sky {width,height} =
  Svg.rect [] []
{--
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
--}
