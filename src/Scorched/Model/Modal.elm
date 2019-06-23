module Scorched.Model.Modal exposing (handleKeyDown, handleKeyUp, handleKeyPress)

import Scorched.Model.Types exposing (Model, Msg, Modal_(..))

import Scorched.Model.World as World
import Scorched.Model.Helper as Helper

handleKeyDown : Modal_ -> Model -> String -> (Model, Cmd Msg)
handleKeyDown modal model key = (model, Cmd.none)
      -- ({ model | menuData = toggleControlByKey model.menuData key }, Cmd.none)

handleKeyUp : Modal_ -> Model -> String -> (Model, Cmd Msg)
handleKeyUp modal model key = (model, Cmd.none)
      -- ({ model | menuData = toggleControlByKey model.menuData key }, Cmd.none)

handleKeyPress : Modal_ -> Model -> String -> (Model, Cmd Msg)
handleKeyPress modal model key = (model, Cmd.none)
      -- (model, handleKeyPress model.config key)
