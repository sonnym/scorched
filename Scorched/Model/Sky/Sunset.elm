module Scorched.Model.Sky.Sunset where

import Color (Color, rgb)

import Scorched.View.Palette (gradient)

generate : List Color
generate =
  gradient (rgb 51 52 150) (rgb 255 235 4) 28
