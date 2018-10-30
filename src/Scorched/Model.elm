module Scorched.Model exposing (default, init, update, subscriptions)

import Scorched.Model.Types exposing (Msg(..), View(..), Model, Configuration, MenuData)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Permutation as Permutation

import Scorched.Model.Keyboard as Keyboard

import Scorched.Model.Menu as Menu
import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

import Scorched.Model.Configuration as Configuration

default : Model
default =
  { view = Menu
  , permutation = Permutation.default
  , menuData = Menu.default
  -- , viewData = {game=GameState.empty}
  , dimensions = {width=1024, height=768}
  , config = Configuration.default
  }

init : Cmd Msg
init = Cmd.batch [ Sky.random, Permutation.random ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MenuSky sky ->
      ({ model | menuData = Menu.updateSky model.menuData sky }, Cmd.none)

    MenuTerrain terrain ->
        ({ model | menuData = Menu.updateTerrain model.menuData terrain }, Cmd.none)

    PermutationGenerated permutation ->
      ({ model | permutation = permutation }, Terrain.random permutation Menu.worldDimensions)

    ButtonToggle label ->
      ({ model | menuData = Menu.toggleButton model.menuData label }, Cmd.none)

    ControlToggle label direction ->
      ({ model | menuData = Menu.toggleControl model.menuData label direction }, Cmd.none)

    KeyDown key ->
      ({ model | menuData = Menu.toggleButtonByKey model.menuData key }, Cmd.none)

    KeyUp key ->
      ({ model | menuData = Menu.toggleButtonByKey model.menuData key }, Cmd.none)

    KeyPress key ->
      case model.view of
        Menu -> ({ model | config = Menu.handleKeyPress model.config key }, Cmd.none)

    UpdateConfig operation spec ->
      ({ model | config = Menu.updateConfig model.config operation spec }, Cmd.none)

    NoOp -> (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch Keyboard.subscriptions
