module Scorched.Model.Sky exposing (..)

import Array
import Random

import Maybe exposing (withDefault)
import Array exposing (Array, fromList, get, length)

type Sky
  = Plain
  | Sunset
  | PitchBlack

type Msg
  = MenuSky Int

random : Cmd Msg
random = Random.generate MenuSky (Random.int 0 2)

getSky : Int -> Sky
getSky n =
  let
    types = Array.fromList [ Plain, Sunset, PitchBlack ]
  in
    Maybe.withDefault PitchBlack (Array.get n types)

empty : Sky
empty = PitchBlack
