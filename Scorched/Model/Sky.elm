module Scorched.Model.Sky where

import Color (Color)

import Maybe (withDefault)
import Array (Array, fromList, get)

import Scorched.Model.Sky.Sunset as SunsetModel

type SkyType
  = SunsetType

type Sky
  = Sunset SunsetModel.Sunset
  | Empty

generate : Sky
generate =
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
