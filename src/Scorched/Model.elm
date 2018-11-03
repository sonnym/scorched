module Scorched.Model exposing (default, init, update, subscriptions)

import Scorched.Model.Types exposing (Msg(..), View(..), Model, Configuration, MainMenuData)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Permutation as Permutation

import Scorched.Model.Keyboard as Keyboard

import Scorched.Model.MainMenu as MainMenu
import Scorched.Model.World as World

import Scorched.Model.Configuration as Configuration

default : Model
default =
  { view = MainMenu
  , permutation = Permutation.default
  , menuData = MainMenu.default
  -- , viewData = {game=GameState.empty}
  , dimensions = {width=1024, height=768}
  , config = Configuration.default
  }

init : Cmd Msg
init = Cmd.batch [ Permutation.random ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    PermutationGenerated permutation ->
      ({ model | permutation = permutation }, World.random permutation MainMenu.worldDimensions)

    MainMenuWorld world ->
        ({ model | menuData = MainMenu.updateWorld model.menuData world }, Cmd.none)

    UpdateView view ->
      ({ model | view = view }, Cmd.none)

    ButtonToggle label ->
      ({ model | menuData = MainMenu.toggleButton model.menuData label }, Cmd.none)

    ControlToggle label direction ->
      ({ model | menuData = MainMenu.toggleControl model.menuData label direction }, Cmd.none)

    KeyDown key ->
      ({ model | menuData = MainMenu.toggleButtonByKey model.menuData key }, Cmd.none)

    KeyUp key ->
      ({ model | menuData = MainMenu.toggleButtonByKey model.menuData key }, Cmd.none)

    KeyPress key ->
      case model.view of
        MainMenu -> ({ model | config = MainMenu.handleKeyPress model.config key }, Cmd.none)

    UpdateConfig operation spec ->
      ({ model | config = MainMenu.updateConfig model.config operation spec }, Cmd.none)

    NoOp -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch Keyboard.subscriptions
