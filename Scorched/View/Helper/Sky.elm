module Scorched.View.Helper.Sky where

import Graphics.Collage (Form)
import Scorched.Model.Geometry (Dimension)
import Scorched.Model.Sky (Sky(Sunset))

import Scorched.View.Helper.Sky.Sunset as SunsetHelper

toForm : Sky -> Dimension -> Form
toForm sky dimensions =
  case sky of
    Sunset sunset -> SunsetHelper.toForm sunset dimensions
