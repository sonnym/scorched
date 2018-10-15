module Scorched.Model.Sky.Sunset exposing (..)

import Color exposing (Color, rgb)

import Scorched.View.Palette exposing (gradient)

type alias Sunset = List Color

generate : Sunset
generate =
  gradient (rgb 51 52 150) (rgb 255 235 4) 28
