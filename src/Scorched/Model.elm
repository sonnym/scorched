module Scorched.Model exposing (..)

import Scorched.Model.Geometry exposing (Dimension)

import Scorched.Model.Sky as Sky exposing(Msg(..))
import Scorched.Model.World as World exposing (World)

-- import Scorched.Model.GameState as GameState exposing (GameState)
-- import Scorched.Model.Configuration as Configuration exposing (Configuration)

type View = Menu -- | Game

type alias Model =
  { view: View
  , sampleWorld: World
  -- , viewData: { game: GameState }
  , dimensions: Dimension
  -- , config: Configuration
  }

default : Model
default =
  { view = Menu
  , sampleWorld = World.empty
  -- , viewData = {game=GameState.empty}
  , dimensions = {width=1024, height=768}
  -- , config = Configuration.default
  }

init : Cmd Msg
init = Sky.random

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MenuSky n ->
      let
        world = model.sampleWorld
        newWorld = { world | sky = Sky.getSky n }
      in
        ({ model | sampleWorld = newWorld }, Cmd.none)
