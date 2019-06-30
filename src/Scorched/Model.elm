module Scorched.Model exposing (default, init, update, subscriptions)

import Time

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  View(..),
  Menu(..),
  Model,
  Permutation,
  Dimension)

import Scorched.Model.Config as Config
import Scorched.Model.Permutation as Permutation
import Scorched.Model.Keyboard as Keyboard

import Scorched.Model.Control as Control
import Scorched.Model.Modal as Modal
import Scorched.Model.Menu.Main as MainMenu

import Scorched.Model.World as World

default : Model
default =
  { view = MenuView Main
  , time = Time.millisToPosix 0
  , ticks = 0
  , controls = Control.dictFromList MainMenu.controls
  , permutation = Permutation.default
  , dimensions = {width=1024, height=768}
  , config = Config.default
  , world = World.default
  , players = []
  }

init : Cmd Msg
init = Permutation.random

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    BasicMsg_ msg_ -> update_ msg_ model
    KeyMsg_ msg_ -> Keyboard.update msg_ model
    ControlMsg_ msg_ -> Control.update msg_ model
    NoOp -> (model, Cmd.none)

update_ : BasicMsg -> Model -> (Model, Cmd Msg)
update_ msg model =
  case msg of
    Tick newTime -> ({ model | time = newTime, ticks = model.ticks + 1 }, Cmd.none)
    WorldGenerated world -> ({ model | world = world }, Cmd.none)

    PermutationGenerated permutation ->
      ({ model | permutation = permutation }, generateWorld permutation model)

    UpdateView view ->
      case view of
        MenuView _ -> (
          { model |
            view = view,
            controls = Control.dictFromList MainMenu.controls
          }, generateWorld model.permutation model)

        ModalView modal -> ({ model | view = view, controls = Modal.controls modal }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch ((Time.every 100 (\n -> (BasicMsg_ (Tick n)))) :: Keyboard.subscriptions)

generateWorld : Permutation -> Model -> Cmd Msg
generateWorld permutation model =
  World.random permutation model.config model.time model.config.worldConfig.dimensions
