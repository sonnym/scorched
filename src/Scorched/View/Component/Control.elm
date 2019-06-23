module Scorched.View.Component.Control exposing (build)

import Svg exposing (Svg)

import Scorched.Model.Types exposing (Msg, Configuration, Control, Specification(..))

import Scorched.View.Component.Control.Button as Button
import Scorched.View.Component.Control.Numeric as Numeric
import Scorched.View.Component.Control.Type as Type

build : Configuration -> Bool -> Control -> Svg Msg
build config disabled ({spec} as control) =
  case spec of
    Button _ -> Button.build control disabled
    Numeric _ -> Numeric.build config control disabled
    Type _ -> Type.build config control disabled
