module Scorched.Model.Noise exposing (generator)

import Array
import Bitwise
import Random

import Scorched.Model.Types exposing (Config, WorldConfig, Permutation)

generator : Permutation -> Config -> Float -> Random.Generator Float
generator permutation {worldConfig} time =
  Random.constant (rounds permutation worldConfig time)

rounds : Permutation -> WorldConfig -> Float -> Float
rounds permutation {bumpiness, slopes} x =
  let
    fallout = (toFloat bumpiness) / 50
    octaves = 8
  in
    List.sum
      (List.map
        (\n -> fallout^n * (1 + (noise permutation (x * (2^n)))) / 2)
        (List.map toFloat (List.range 0 (octaves - 1))))

noise : Permutation -> Float -> Float
noise permutation x =
  let
    base = Bitwise.and (floor x) 255
    remainder = x - toFloat (floor x)
  in
    lerp
      (fade remainder)
      (grad (perm permutation base) remainder)
      (grad (perm permutation (base + 1)) (remainder - 1))

fade : Float -> Float
fade x = (3 - 2 * x) * x * x

lerp : Float -> Float -> Float -> Float
lerp t a b = a + t * (b - a)

grad : Int -> Float -> Float
grad i x = if (Bitwise.and i 1 == 0) then negate x else x

perm : Permutation -> Int -> Int
perm permutation x =
  case Array.get x (Array.fromList (List.append permutation permutation)) of
    Just n -> n
    Nothing -> 0
