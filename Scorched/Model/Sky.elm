module Scorched.Model.Sky where

import Color (Color)
import Random (Seed)

import Maybe (withDefault)
import Array (Array, fromList, get)

import Scorched.Model.Sky.Sunset as SunsetModel

type SkyType
  = SunsetType

type Sky
  = Sunset SunsetModel.Sunset
  | Empty

generate : Seed -> Sky
generate seed =
  let
    skyType = withDefault SunsetType (get 0 types)
  in
    case skyType of
      SunsetType -> Sunset (SunsetModel.generate)

types : Array SkyType
types =
  fromList [SunsetType]

empty : Sky
empty = Empty
