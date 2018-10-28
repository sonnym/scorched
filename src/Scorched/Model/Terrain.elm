module Scorched.Model.Terrain exposing (empty, random)

import Random
import Random.Extra

import Scorched.Model.Noise as Noise

import Scorched.Model.Types exposing (Permutation, Action(..), Terrain)
import Scorched.Model.Geometry exposing (Dimension)

random : Permutation -> Dimension -> Cmd Action
random permutation dimensions =
  Random.generate MenuTerrain (generator permutation dimensions)

generator : Permutation -> Dimension -> Random.Generator Terrain
generator permutation {width, height} =
  Random.Extra.combine
    (List.map
      (\x -> Random.map (\n -> round (n * (toFloat (height // 2)))) (Noise.generator permutation x))
      (List.map (\n -> (0.002 * toFloat n)) (List.range 1 width)))

empty : Terrain
empty = []
