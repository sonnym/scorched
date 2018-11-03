module Scorched.Model.SubMenu exposing (handleKeyUp)

import Task

import Scorched.Model.Types exposing (Msg(..), View(..))
import Scorched.Model.Permutation as Permutation

handleKeyUp : String -> Cmd Msg
handleKeyUp key =
  case key of
    "Escape" ->
      Cmd.batch
        [ (Task.succeed (UpdateView MainMenu) |> Task.perform identity)
        , Permutation.random
        ]
    _ -> Task.succeed NoOp |> Task.perform identity
