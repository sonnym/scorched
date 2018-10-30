module Scorched.Model.Sky exposing (empty, generator)

import Random

import Scorched.Model.Types exposing (Msg(..), Sky(..))

import Maybe exposing (withDefault)
import Array exposing (Array, fromList, get, length)

generator : Random.Generator Sky
generator = Random.uniform empty [ PitchBlack, Plain, Sunset ]

empty : Sky
empty = PitchBlack
