module Scorched.View.Component.Control exposing (build)

import Svg exposing (Svg)

import Scorched.Model.Types exposing (Msg, Config, Control, Specification(..))

import Scorched.View.Component.Control.Button as ButtonControl
import Scorched.View.Component.Control.Integer as IntegerControl
import Scorched.View.Component.Control.String as StringControl

build : Config -> Bool -> Control -> Svg Msg
build config disabled ({spec} as control) =
  case spec of
    Button _ -> ButtonControl.build control disabled
    Integer _ -> IntegerControl.build config control disabled
    String _ -> StringControl.build config control disabled
