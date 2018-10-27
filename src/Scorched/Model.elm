module Scorched.Model exposing (..)

import Scorched.Action exposing (Action(..))
import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Menu as Menu exposing (MenuData)
import Scorched.Model.Sky as Sky
import Scorched.Model.World as World exposing (World)

-- import Scorched.Model.GameState as GameState exposing (GameState)
-- import Scorched.Model.Configuration as Configuration exposing (Configuration)

type View = Menu -- | Game

type alias Model =
  { view: View
  , sampleWorld: World
  , menuData: MenuData
  -- , viewData: { game: GameState }
  , dimensions: Dimension
  -- , config: Configuration
  }

default : Model
default =
  { view = Menu
  , sampleWorld = World.empty
  , menuData = Menu.default
  -- , viewData = {game=GameState.empty}
  , dimensions = {width=1024, height=768}
  -- , config = Configuration.default
  }

init : Cmd Action
init = Sky.random

update : Action -> Model -> (Model, Cmd Action)
update msg model =
  case msg of
    MenuSky n ->
      let
        world = model.sampleWorld
        newWorld = { world | sky = Sky.getSky n }
      in
        ({ model | sampleWorld = newWorld }, Cmd.none)

    ButtonDown label ->
      let
        menuData = Menu.updateMenuData model.menuData label
      in
        ({ model | menuData = menuData }, Cmd.none)

    NoOp -> (model, Cmd.none)
