module Scorched.Model.Sky exposing (empty, generator)

import Random

import Scorched.Model.Types exposing (Sky(..))

generator : Random.Generator Sky
generator = Random.uniform empty [ PitchBlack, Plain, Sunset ]

empty : Sky
empty = PitchBlack
