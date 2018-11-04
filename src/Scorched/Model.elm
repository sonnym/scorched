module Scorched.Model exposing (default, init, update, subscriptions)

import Time

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
    Tick newTime -> ({ model | time = newTime }, Cmd.none)

    PermutationGenerated permutation ->
      ({ model | permutation = permutation }, World.random permutation model.time MainMenu.worldDimensions)

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
        SubMenu _ -> (model, SubMenu.handleKeyUp model key)

    KeyPress key ->
      case model.view of
        MainMenu -> (model, MainMenu.handleKeyPress model.config key)
        SubMenu _ -> (model, Cmd.none)

    UpdateConfig operation spec ->
      case model.view of
        MainMenu ->
          ({ model | config = MainMenu.updateModelConfig model.config operation spec }, Cmd.none)
        SubMenu _ -> (model, Cmd.none)

    NoOp -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch ((Time.every 1000 Tick) :: Keyboard.subscriptions)
