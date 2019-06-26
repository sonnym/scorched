module Scorched.Model.Modal.Landscape exposing (controls)

import Scorched.Model.Types exposing (Control, Direction(..), Specification(..), StringControlSpec)

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
        toggle)) ]
