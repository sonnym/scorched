module Scorched.Model.Window where

import Graphics.Collage (..)

import Scorched.Model.World (Dimension)

(width, height) = (1024, 768)

dimensions : Dimension
dimensions = {width=1024, height=768}

transformCoordinates : Float -> Float -> Form -> Form
transformCoordinates width height form =
  move (-(width / 2), (height / 2) + 1.0) form
