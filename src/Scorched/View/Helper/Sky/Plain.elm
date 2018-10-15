module Scorched.View.Helper.Sky.Plain exposing (..)

import Color exposing (rgb)
import Graphics.Collage exposing (Form, rect, filled)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky.Plain exposing (Plain)

toForm : Plain -> Dimension -> Form
toForm _ {width,height} =
  rect (toFloat width) (toFloat height)
    |> filled (rgb 36 36 125)
