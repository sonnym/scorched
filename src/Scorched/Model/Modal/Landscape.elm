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
        (\config -> Sky.toString config.worldSettings.sky)
        (\config sky ->
          let
            oldWorldSettings = config.worldSettings
            newWorldSettings = { oldWorldSettings | sky = Sky.fromString sky }
          in
            { config | worldSettings = newWorldSettings }
        )
        action
        toggle)) ]
