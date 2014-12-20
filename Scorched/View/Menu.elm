module Scorched.View.Menu where

import Scorched.Model.World (Dimension)
import Scorched.View.Widget.BorderBox as BorderBox

import Graphics.Element (..)
import Graphics.Collage (..)

renderMenu : Dimension -> Element
renderMenu dimensions = BorderBox.build dimensions
