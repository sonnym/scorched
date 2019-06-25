module Scorched.Model.Menu exposing (update)

import Scorched.Model.Types exposing (Model, Msg, View(..), MenuMsg(..))

import Scorched.Model.Control as Control
import Scorched.Model.Menu.Main as MainMenu

update : MenuMsg -> Model -> (Model, Cmd Msg)
update msg ({view} as model) =
  case view of
    MenuView _ -> MainMenu.update msg model
    _ -> (model, Cmd.none)
