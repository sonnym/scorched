module Scorched.View.Helper.Sky.Plain where

import Color (rgb)
import Graphics.Collage (Form, rect, filled)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.Sky.Plain (Plain)

toForm : Plain -> Dimension -> Form
toForm _ {width,height} =
  rect (toFloat width) (toFloat height)
    |> filled (rgb 36 36 125)
