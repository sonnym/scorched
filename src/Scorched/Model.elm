module Scorched.Model exposing (..)

import Scorched.Action exposing (Action(..))
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Menu as Menu exposing (MenuData)
import Scorched.Model.Sky as Sky

-- import Scorched.Model.GameState as GameState exposing (GameState)
import Scorched.Model.Configuration as Configuration exposing (Configuration)

type View = Menu -- | Game

type alias Model =
  { view: View
  , menuData: MenuData
  -- , viewData: { game: GameState }
  , dimensions: Dimension
  , config: Configuration
  }

default : Model
default =
  { view = Menu
  , menuData = Menu.default
  -- , viewData = {game=GameState.empty}
  , dimensions = {width=1024, height=768}
  , config = Configuration.default
  }

init : Cmd Action
init = Sky.random

update : Action -> Model -> (Model, Cmd Action)
update msg model =
  case msg of
    MenuSky n ->
      ({ model | menuData = Menu.updateMenuWorld model.menuData n }, Cmd.none)

    ButtonToggle label ->
      ({ model | menuData = Menu.toggleButton model.menuData label }, Cmd.none)

    ControlToggle label direction ->
      ({ model | menuData = Menu.toggleControl model.menuData label direction }, Cmd.none)

    NoOp -> (model, Cmd.none)
