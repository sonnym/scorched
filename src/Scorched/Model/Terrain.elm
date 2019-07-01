module Scorched.Model.Terrain exposing (empty, generator)

import Random
import Random.Extra
import Time

import Scorched.Model.Noise as Noise

import Scorched.Model.Types exposing (Msg(..), Config, Permutation, Terrain, Dimension)
import Scorched.View.Palette exposing (Color, background)

generator : Permutation -> Config -> Time.Posix -> Dimension -> Random.Generator Terrain
generator permutation config time dimensions =
  Random.map2
    create
    (altitudesGenerator permutation config time dimensions)
    colorGenerator

altitudesGenerator : Permutation -> Config -> Time.Posix -> Dimension -> Random.Generator (List Int)
altitudesGenerator permutation ({worldConfig} as config) time {width, height} =
  Random.Extra.combine
    (List.map
      (\x -> Random.map (scale height) (Noise.generator permutation config (toFloat (Time.toMillis Time.utc time) + x)))
      (List.map (\n -> ((toFloat config.worldConfig.slopes / 1000) * toFloat n)) (List.range 1 width)))

colorGenerator : Random.Generator Color
colorGenerator = Random.uniform background colors

scale : Int -> Float -> Int
scale max n = round (n * (toFloat max / 3))

empty : Terrain
empty = create [] background

create : List Int -> Color -> Terrain
create altitudes color =
  { altitudes = altitudes
  , color = color
  }

colors : List Color
colors =
  [ { r = 36, g = 142, b = 36 }
  , { r = 154, g = 101, b = 69 }
  , { r = 142, g = 216, b = 112 }
  , { r = 215, g = 215, b = 190 }
  , { r = 219, g = 146, b = 113 }
  ]
