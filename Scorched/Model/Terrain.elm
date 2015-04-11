module Scorched.Model.Terrain where

import Random exposing (Seed, list, int)

import Scorched.Model.Geometry exposing (Dimension)

type alias Terrain = List Int

generate : Seed -> Dimension -> Terrain
generate seed {width,height} =
  let
    (terrain, _) = Random.generate (list width (int 0 height)) seed
  in
    terrain
