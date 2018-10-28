module Scorched.Model.Terrain exposing (empty, random)

import Random
import Scorched.Model.Noise as Noise

import Scorched.Model.Types exposing (Model, Action(..), Terrain)
import Scorched.Model.Geometry exposing (Dimension)

random : Model -> Cmd Action
random model =
  Random.generate MenuTerrain (generator model)

generator : Model -> Random.Generator Terrain
generator ({dimensions} as model) =
  combine
    (List.map
      (\x -> Random.map (\n -> round (n * (toFloat (dimensions.height // 2)))) (Noise.generator model x))
      (List.map (\n -> (0.002 * toFloat n)) (List.range 1 dimensions.width)))

empty : Terrain
empty = []

combine : List (Random.Generator a) -> Random.Generator (List a)
combine generators =
  case generators of
    [] -> Random.constant []
    g :: gs -> Random.map2 (::) g (combine gs)
