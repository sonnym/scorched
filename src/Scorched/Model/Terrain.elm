module Scorched.Model.Terrain exposing (empty, generator)

import Random
import Random.Extra

import Scorched.Model.Noise as Noise

import Scorched.Model.Types exposing (Permutation, Msg(..), Terrain)
import Scorched.Model.Geometry exposing (Dimension)

generator : Permutation -> Dimension -> Random.Generator Terrain
generator permutation {width, height} =
  Random.Extra.combine
    (List.map
      (\x -> Random.map (scale height)  (Noise.generator permutation x))
      (List.map (\n -> (0.002 * toFloat n)) (List.range 1 width)))

scale : Int -> Float -> Int
scale max n = round (n * (toFloat (max // 3)))

empty : Terrain
empty = []
