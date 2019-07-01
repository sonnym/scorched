port module Scorched.Model.Ports exposing (..)

import Scorched.Model.Types exposing (Msg(..), BasicMsg(..))

port setVersion : (String -> msg) -> Sub msg

subscriptions : List (Sub Msg)
subscriptions = List.singleton (setVersion (\version -> BasicMsg_ (SetVersion version)))
