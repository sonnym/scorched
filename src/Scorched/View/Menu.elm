module Scorched.View.Menu exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr

import Scorched.Model.Types exposing (Model, Msg, Menu_(..))

import Scorched.View.Menu.Main as MainMenu

build : Menu_ -> Model -> Svg Msg
build menu ({dimensions} as model) =
  case menu of
    Main -> MainMenu.build model
