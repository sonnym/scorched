module Scorched.Model.Permutation exposing (default, random)

import Random
import Random.List

import Scorched.Model.Types exposing (Msg(..), BasicMsg(..), Permutation)

random : Cmd Msg
random = Random.generate
  (\permutation -> Basic (PermutationGenerated permutation))
  generator

generator : Random.Generator Permutation
generator = Random.List.shuffle (List.range 0 255)

default : Permutation
default = [ ]
