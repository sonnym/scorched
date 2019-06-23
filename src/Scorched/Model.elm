module Scorched.Model exposing (default, init, update, subscriptions)

import Time

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  View(..),
  Menu_(..),
  Model,
  MainMenuData,
  Dimension)

import Scorched.Model.Configuration as Configuration
import Scorched.Model.Permutation as Permutation
import Scorched.Model.Keyboard as Keyboard

import Scorched.Model.Menu.Main as MainMenu
import Scorched.Model.Modal as Modal

import Scorched.Model.World as World

default : Model
default =
  { view = MenuView Main
  , time = Time.millisToPosix 0
  , permutation = Permutation.default
  , menuData = MainMenu.default
  , dimensions = {width=1024, height=768}
  , config = Configuration.default
  }

init : Cmd Msg
init = Permutation.random

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> (model, Cmd.none)
    Basic msg_ -> update_ msg_ model
    Key msg_ -> Keyboard.update msg_ model
    MainMenu msg_ -> MainMenu.update msg_ model
    Modal _ -> (model, Cmd.none)

update_ : BasicMsg -> Model -> (Model, Cmd Msg)
update_ msg model =
  case msg of
    Tick newTime -> ({ model | time = newTime }, Cmd.none)

    PermutationGenerated permutation ->
      ( { model | permutation = permutation }
      , World.random permutation model.config.noiseSettings model.time MainMenu.worldDimensions
      )

    UpdateView view ->
      case view of
        MenuView _ -> ({ model | view = view, menuData = resetMenuData model.menuData }, Cmd.none)
        _ -> ({ model | view = view }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch ((Time.every 100 (\n -> (Basic (Tick n)))) :: Keyboard.subscriptions)

resetMenuData : MainMenuData -> MainMenuData
resetMenuData menuData = { menuData | controls = MainMenu.default.controls }
