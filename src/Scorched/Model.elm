module Scorched.Model exposing (default, init, update, subscriptions)

import Scorched.Model.Types exposing (Msg(..), View(..), Model, MainMenuData, Direction(..))
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Permutation as Permutation

import Scorched.Model.Keyboard as Keyboard
import Scorched.Model.Configuration as Configuration

import Scorched.Model.MainMenu as MainMenu
import Scorched.Model.SubMenu as SubMenu

import Scorched.Model.World as World

default : Model
default =
  { view = MainMenu
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
    PermutationGenerated permutation ->
      ({ model | permutation = permutation }, World.random permutation MainMenu.worldDimensions)

    UpdateView view ->
      ({ model | view = view }, Cmd.none)

    MainMenuWorld world ->
      ({ model | menuData = MainMenu.updateWorld model.menuData world }, Cmd.none)

    ControlToggle label direction ->
      case model.view of
        MainMenu ->
          ({ model | menuData = MainMenu.toggleControl model.menuData label direction }, Cmd.none)
        SubMenu _ -> (model, Cmd.none)

    KeyDown key ->
      case model.view of
        MainMenu ->
          ({ model | menuData = MainMenu.toggleControlByKey model.menuData key }, Cmd.none)
        SubMenu _ -> (model, Cmd.none)

    KeyUp key ->
      case model.view of
        MainMenu ->
          ({ model | menuData = MainMenu.toggleControlByKey model.menuData key }, Cmd.none)
        SubMenu _ -> (model, SubMenu.handleKeyUp key)

    KeyPress key ->
      case model.view of
        MainMenu -> ({ model | config = MainMenu.handleKeyPress model.config key }, Cmd.none)
        SubMenu _ -> (model, Cmd.none)

    UpdateConfig operation spec ->
      case model.view of
        MainMenu ->
          ({ model | config = MainMenu.updateModelConfig model.config operation spec }, Cmd.none)
        SubMenu _ -> (model, Cmd.none)

    NoOp -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch Keyboard.subscriptions
