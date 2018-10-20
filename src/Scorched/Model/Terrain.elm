module Scorched.Model.Terrain exposing (..)

import Random exposing (..)

import Scorched.Model.Geometry exposing (Dimension)

type alias Terrain = List Int

generate : Random.Generator Int -> Dimension -> Terrain
generate seed {width,height} = [1]
{--
  let
    (terrain, _) = Random.generate (list width (int 0 height)) seed
  in
    terrain
--}
