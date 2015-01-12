module Scorched.View.Helper.World where

import List (length)

import Graphics.Element (empty)

import Graphics.Collage as Collage
import Graphics.Collage (Form, group, moveY)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.World (World)

import Scorched.View.Helper.Terrain as TerrainHelper
import Scorched.View.Helper.Sky as SkyHelper

toForm : World -> Dimension -> Form
toForm world dimensions =
  if | (length world.terrain) == 0 -> emptyWorld
     | otherwise -> fullWorld world dimensions

emptyWorld : Form
emptyWorld = Collage.toForm empty

fullWorld : World -> Dimension -> Form
fullWorld world ({height} as dimensions) =
  let
    sky = SkyHelper.toForm world.sky dimensions
    terrain = TerrainHelper.toForm world.terrain dimensions

    terrainHeight = TerrainHelper.height world.terrain
  in
    group [sky, (terrain |> moveY -((toFloat (height - terrainHeight)) / 2.0))]
