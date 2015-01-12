module Scorched.View.Helper.Sky.PitchBlack where

import Color (rgb)
import Graphics.Collage (Form, rect, filled)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.Sky.PitchBlack (PitchBlack)

toForm : PitchBlack -> Dimension -> Form
toForm _ {width,height} =
  rect (toFloat width) (toFloat height)
    |> filled (rgb 0 0 0)
