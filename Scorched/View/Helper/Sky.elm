module Scorched.View.Helper.Sky where

import Graphics.Collage (Form)
import Scorched.Model.Geometry (Dimension)
import Scorched.Model.Sky (Sky(Sunset, PitchBlack))

import Scorched.View.Helper.Sky.Sunset as SunsetHelper
import Scorched.View.Helper.Sky.Plain as PlainHelper
import Scorched.View.Helper.Sky.PitchBlack as PitchBlackHelper

toForm : Sky -> Dimension -> Form
toForm sky dimensions =
  case sky of
    Sunset sunset -> SunsetHelper.toForm sunset dimensions
    Plain pitchblack -> PlainHelper.toForm pitchblack dimensions
    PitchBlack pitchblack -> PitchBlackHelper.toForm pitchblack dimensions
