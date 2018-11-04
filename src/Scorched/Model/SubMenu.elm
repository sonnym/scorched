module Scorched.Model.SubMenu exposing (handleKeyUp)

import Scorched.Model.Types exposing (Msg(..), View(..))
import Scorched.Model.Permutation as Permutation

import Scorched.Model.Helper as Helper

handleKeyUp : String -> Cmd Msg
handleKeyUp key =
  case key of
    "Escape" ->
      Cmd.batch
        [ Helper.send (UpdateView MainMenu)
        , Permutation.random
        ]
    _ -> Helper.send NoOp
