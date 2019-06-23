module Scorched.View.Helper exposing (translate)

import Scorched.Model.Types exposing (Offset)

translate : Offset -> String
translate {x, y} =
  "translate(" ++ String.fromInt x ++ ", " ++ String.fromInt y ++ ")"
