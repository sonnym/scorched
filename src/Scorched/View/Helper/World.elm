module Scorched.View.Helper.World exposing (..)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.World exposing (World)

-- import Scorched.View.Helper.Terrain as TerrainHelper
import Scorched.Model.Sky exposing (Sky(..))
import Scorched.View.Sky as Sky

build : World -> Dimension -> Svg msg
build world dimensions =
  Svg.g [] [ sky dimensions ]

sky : Dimension -> Svg msg
sky dimensions =
  Sky.build (PitchBlack 0) dimensions

{--
  if | (List.length world.terrain) == 0 -> emptyWorld
     | otherwise -> fullWorld world dimensions

emptyWorld : Form
emptyWorld = Collage.toForm empty

fullWorld : World -> Dimension -> Form
fullWorld world ({height} as dimensions) =
  let
    sky = SkyHelper.toForm world.sky dimensions
    terrain = TerrainHelper.toForm world.terrain dimensions

    terrainHeight = TerrainHelper.maxHeight world.terrain
  in
    group [sky, (terrain |> moveY -((toFloat (height - terrainHeight)) / 2.0))]
--}
