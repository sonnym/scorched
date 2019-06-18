module Scorched.Model.Modal exposing (update)

import Scorched.Model.Types exposing (Model, Msg(..), BasicMsg(..))
import Scorched.Model.Types.ModalMsg exposing (..)
import Scorched.Model.Types.View exposing (..)

import Scorched.Model.World as World
import Scorched.Model.MainMenu as MainMenu

import Scorched.Model.Helper as Helper

update : ModalMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case model.view of
    Modal_ modal -> update_ msg model
    _ -> (model, Cmd.none)

update_ : ModalMsg -> Model -> (Model, Cmd Msg)
update_ msg model =
  case msg of
    KeyUp key -> (model, handleKeyUp model key)

handleKeyUp : Model -> String -> Cmd Msg
handleKeyUp {permutation, config, time} key =
  case key of
    "Escape" ->
      Cmd.batch
        [ Helper.send (Basic (UpdateView (Menu_ Main)))
        , World.random permutation config.noiseSettings time MainMenu.worldDimensions
        ]
    _ -> Helper.send NoOp
