module Scorched.Model exposing (..)

import Scorched.Model.Types exposing (Action(..), View(..), Model, Configuration, MenuData)
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Noise as Noise

import Scorched.Model.Menu as Menu
import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

-- import Scorched.Model.GameState as GameState exposing (GameState)
import Scorched.Model.Configuration as Configuration

default : Model
default =
  { view = Menu
  , permutation = Noise.defaultPermutation
  , menuData = Menu.default
  -- , viewData = {game=GameState.empty}
  , dimensions = {width=1024, height=768}
  , config = Configuration.default
  }

init : Cmd Action
init = Cmd.batch [ Sky.random, (Terrain.random default) ]

update : Action -> Model -> (Model, Cmd Action)
update msg model =
  case msg of
    MenuSky sky ->
      ({ model | menuData = Menu.updateSky model.menuData sky }, Cmd.none)

    MenuTerrain terrain ->
        ({ model | menuData = Menu.updateTerrain model.menuData terrain }, Cmd.none)

    ButtonToggle label ->
      ({ model | menuData = Menu.toggleButton model.menuData label }, Cmd.none)

    ControlToggle label direction ->
      ({ model | menuData = Menu.toggleControl model.menuData label direction }, Cmd.none)

    UpdateConfig operation spec ->
      ({ model | config = Menu.updateConfig model.config operation spec }, Cmd.none)

    NoOp -> (model, Cmd.none)
