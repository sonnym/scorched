module Scorched.Model.Helper exposing (send)

import Task

import Scorched.Model.Types exposing (Msg)

send : Msg -> Cmd Msg
send msg = Task.perform identity (Task.succeed msg)
