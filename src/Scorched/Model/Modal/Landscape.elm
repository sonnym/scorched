module Scorched.Model.Modal.Landscape exposing (controls)

import Scorched.Model.Types exposing (
  Control,
  Direction(..),
  Specification(..),
  StringControlSpec,
  IntegerControlSpec)

import Scorched.Model.Control exposing (action, toggle)
import Scorched.Model.Sky as Sky

controls : List Control
controls =
  [ Control "Sky" 'S' {x=7, y=12}
    (String
      (StringControlSpec
        (List.map Sky.toString Sky.all)
        None
        (\config -> Sky.toString config.worldConfig.sky)
        (\config sky ->
          let
            oldWorldConfig = config.worldConfig
            newWorldConfig = { oldWorldConfig | sky = Sky.fromString sky }
          in
            { config | worldConfig = newWorldConfig }
        )
        action
        toggle))

  , Control "Bumpiness" 'B' {x=8, y=40}
    (Integer (IntegerControlSpec 0 100 2 None (\config -> config.worldConfig.bumpiness)
      (\config n ->
        let
          oldWorldConfig = config.worldConfig
          newWorldConfig = { oldWorldConfig | bumpiness = n }
        in
          { config | worldConfig = newWorldConfig }
      ) action toggle))

  , Control "Slopes" 'l' {x=8, y=70}
    (Integer (IntegerControlSpec 0 100 2 None (\config -> config.worldConfig.slopes)
      (\config n ->
        let
          oldWorldConfig = config.worldConfig
          newWorldConfig = { oldWorldConfig | slopes = n }
        in
          { config | worldConfig = newWorldConfig }
      ) action toggle))
  ]
