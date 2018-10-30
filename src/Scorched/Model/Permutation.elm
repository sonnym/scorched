module Scorched.Model.Permutation exposing (default, random)

import Random
import Random.List

import Scorched.Model.Types exposing (Msg(..), Permutation)

random : Cmd Msg
random = Random.generate PermutationGenerated generator

generator : Random.Generator Permutation
generator = Random.List.shuffle (List.range 0 255)

default : Permutation
default = [ ]

