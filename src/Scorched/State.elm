module Scorched.State exposing (..)

import List exposing ((::), foldr, filter, length, head)
import Char exposing (toCode)

import Random exposing (Seed, initialSeed)

import Scorched.Model exposing (Model, View(..), default)
import Scorched.Input exposing (Input, keypress)

import Scorched.Action exposing (Hook, Action(..), updates)
-- import Scorched.Model.GameState as GameState

-- import Scorched.Model.Configuration as Configuration exposing (Configuration)

-- import Scorched.Model.View.Menu as MenuModel

state : Model
state = default

{--
signal : Signal (Action, Input, Seed)
signal =
  let
    actions = merge (constant Initialize) (subscribe updates)
    combination = map3 (\action input seed -> (action, input, seed)) actions keypress seeds
  in
    sampleOn (fps 60) combination

seeds : Signal Seed
seeds = map (\(time, _) -> initialSeed (round time)) (timestamp (constant ()))

step : (Action, Input, Seed) -> Model -> Model
step (action, input, seed) ({hooks} as model) =
  let
    actions = action :: (List.map (lookup hooks) input)
  in
    foldr (apply seed) model actions

apply : Seed -> Action -> Model -> Model
apply seed action model =
  case action of
    NoOp -> model
    Initialize ->
      { model = hooks <- MenuModel.hooks
      , viewData = {game=GameState.init seed MenuModel.worldDimensions}
      }
    Configuration a -> { model = config Configuration.step a model.config }
    Start ->
      { model = view <- Game
      , viewData = {game=GameState.init seed model.dimensions}
      }

lookup : List Hook -> Int -> Action
lookup hooks keyCode =
  let
    match = filter (\pair -> (toCode (fst pair)) == keyCode) hooks
  in
    if length match > 0 then snd (head match) else NoOp
--}
