module Scorched.View.Component.Control exposing (build)

import Svg exposing (Svg)

import Scorched.Model.Types exposing (Msg, Configuration, Control, Specification(..))

import Scorched.View.Component.Button as Button
import Scorched.View.Component.Numeric as Numeric

build : Configuration -> Control -> Svg Msg
build config ({spec} as control) =
  case spec of
    Button _ -> Button.build control
    Numeric _ -> Numeric.build config control
