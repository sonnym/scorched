module Scorched.View.Helper.Sky.PitchBlack exposing (..)

import Color exposing (rgb)
import Graphics.Collage exposing (Form, rect, filled)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky.PitchBlack exposing (PitchBlack)

toForm : PitchBlack -> Dimension -> Form
toForm _ {width,height} =
  rect (toFloat width) (toFloat height)
    |> filled (rgb 0 0 0)
