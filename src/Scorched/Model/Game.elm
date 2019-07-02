module Scorched.Model.Game exposing (update)

import Scorched.Model.Types exposing (
  Msg(..),
  BasicMsg(..),
  GameMsg(..),
  View(..),
  Model,
  Dimension)

import Scorched.Model.World as World
import Scorched.Model.Helper as Helper

update : GameMsg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Initialize -> start model

start : Model -> (Model, Cmd Msg)
start ({config, permutation, time} as model) =
  let
    oldWorldConfig = config.worldConfig
    newWorldConfig = { oldWorldConfig | dimensions = gameWorldSize }
    newConfig = { config | worldConfig = newWorldConfig }
  in
    ( { model | config = newConfig }
    ,  Cmd.batch
        [ World.random permutation config time config.worldConfig.dimensions
        , Helper.send (BasicMsg_ (UpdateView GamePlay))
        ]
    )

gameWorldSize : Dimension
gameWorldSize = {width=1034, height=743}
