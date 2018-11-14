module Scorched.Model.Modal exposing (handleKeyUp)

import Scorched.Model.Types exposing (Model, Msg(..), View(..))

import Scorched.Model.World as World
import Scorched.Model.MainMenu as MainMenu

import Scorched.Model.Helper as Helper

handleKeyUp : Model -> String -> Cmd Msg
handleKeyUp {permutation, noiseSettings, time} key =
  case key of
    "Escape" ->
      Cmd.batch
        [ Helper.send (UpdateView MainMenu)
        , World.random permutation noiseSettings time MainMenu.worldDimensions
        ]
    _ -> Helper.send NoOp
