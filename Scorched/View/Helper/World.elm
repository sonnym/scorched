module Scorched.View.Helper.World where

import Graphics.Collage (Form, group, moveY)

import Scorched.Model.Geometry (Dimension)

import Scorched.Model.World (World)

import Scorched.View.Helper.Terrain as TerrainHelper
import Scorched.View.Helper.Sky as SkyHelper

toForm : World -> Dimension -> Form
toForm world ({height} as dimensions) =
  let
    sky = SkyHelper.toForm world.sky dimensions
    terrain = TerrainHelper.toForm world.terrain dimensions

    terrainHeight = TerrainHelper.height world.terrain
  in
    group [sky, (terrain |> moveY -((toFloat (height - terrainHeight)) / 2.0))]