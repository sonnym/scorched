module Scorched.Model.Modal.Landscape exposing (controls)

import Scorched.Model.Types exposing (Control, Direction(..), Specification(..), TypeSpec)

import Scorched.Model.Control exposing (action, toggle)
import Scorched.Model.Sky as Sky

controls : List Control
controls =
  [ Control "Sky" 'S' {x=7, y=12}
    (Type
      (TypeSpec
        (List.map Sky.toString Sky.all)
        None
        (\config -> Sky.toString config.worldSettings.sky)
        (\config sky ->
          let
            oldWorldSettings = config.worldSettings
            newWorldSettings = { oldWorldSettings | sky = Sky.fromString (Debug.log "sky set to" sky) }
          in
            { config | worldSettings = newWorldSettings }
        )
        action
        toggle)) ]
