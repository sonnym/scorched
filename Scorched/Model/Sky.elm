module Scorched.Model.Sky where

import Color (Color, rgb)

import Scorched.View.Palette (gradient)

type alias Sky = List Color

generate : Sky
generate =
  gradient (rgb 51 52 150) (rgb 255 235 4) 28
