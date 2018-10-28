module Scorched.Model.Terrain exposing (empty, random)

import Random
import Scorched.Model.Noise as Noise

import Scorched.Model.Types exposing (Action(..), Terrain)
import Scorched.Model.Geometry exposing (Dimension)

random : Dimension -> Cmd Action
random dimension =
  Random.generate MenuTerrain (generator dimension)

generator : Dimension -> Random.Generator Terrain
generator {width, height} =
  combine
    (List.map
      (\x -> Random.map (\n -> round (n * (toFloat (height // 2)))) (Noise.generator x))
      (List.map (\n -> (0.002 * toFloat n)) (List.range 1 width)))

empty : Terrain
empty = []

combine : List (Random.Generator a) -> Random.Generator (List a)
combine generators =
  case generators of
    [] -> Random.constant []
    g :: gs -> Random.map2 (::) g (combine gs)
