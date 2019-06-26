module Scorched.Model.Control exposing (
  dictFromList,
  update,
  toggle,
  action,
  handleKeyPress,
  toggleControl,
  toggleControlByKey)

import Dict exposing (Dict)

import Scorched.Model.Types exposing (
  Msg(..),
  ControlMsg(..),
  Specification(..),
  Direction(..),
  Operation(..),
  Model,
  Config,
  Control)

import Scorched.Model.Control.Integer as IntegerControl
import Scorched.Model.Control.String as StringControl

import Scorched.Model.Helper as Helper

dictFromList : List Control -> Dict String Control
dictFromList controls =
  Dict.fromList (List.map (\control -> (control.label, control)) controls)

update : ControlMsg -> Model -> (Model, Cmd Msg)
update msg ({controls, config} as model) =
  case msg of
    ControlToggle direction label ->
      ({ model | controls = toggleControl controls label direction }, Cmd.none)

    UpdateConfig operation spec ->
      ({ model | config = updateModelConfig config operation spec }, Cmd.none)

toggle : Direction -> String -> Msg
toggle direction label = ControlMsg_ (ControlToggle direction label)

action : Direction -> Control -> Msg
action direction ({spec} as control) =
  case spec of
    Integer _ ->
      case direction of
        Up -> (ControlMsg_ (UpdateConfig Increment spec))
        Down -> (ControlMsg_ (UpdateConfig Decrement spec))
        None -> NoOp

    String _ ->
      case direction of
        Up -> (ControlMsg_ (UpdateConfig Increment spec))
        Down -> (ControlMsg_ (UpdateConfig Decrement spec))
        None -> NoOp

    _ -> NoOp

handleKeyPress : Dict String Control -> Config -> String -> Cmd Msg
handleKeyPress controls config key =
  let
    maybeControl = List.head (Dict.values (findItem controls key))
  in
    case maybeControl of
      Just control ->
        case control.spec of
          Button buttonSpec -> Helper.send buttonSpec.action
          Integer _ -> Helper.send (ControlMsg_ (UpdateConfig Increment control.spec))
          String _ -> Helper.send (ControlMsg_ (UpdateConfig Increment control.spec))
      Nothing -> Cmd.none

toggleControlByKey : Dict String Control -> String -> Dict String Control
toggleControlByKey controls key =
  let
    maybeLabel = List.head (Dict.keys (findItem controls key))
  in
    case maybeLabel of
      Just label -> toggleControl controls label Up
      Nothing -> controls

updateModelConfig : Config -> Operation -> Specification -> Config
updateModelConfig config operation spec =
  case spec of
    Integer integer -> IntegerControl.updateConfig config operation integer
    String string -> StringControl.updateConfig config operation string
    _ -> config

toggleControl : Dict String Control -> String -> Direction -> Dict String Control
toggleControl controls label direction =
  Dict.update label (updateControl direction) controls

updateControl : Direction -> Maybe Control -> Maybe Control
updateControl direction maybeControl =
  case maybeControl of
    Just ({spec} as control) ->
      case spec of
        Button button ->
          let newSpec = { button | invert = not button.invert }
          in Just { control | spec = Button newSpec }

        Integer integer ->
          let newSpec = { integer | invert = (if integer.invert == direction then None else direction) }
          in Just { control | spec = Integer newSpec }

        String string ->
          let newSpec = { string | invert = (if string.invert == direction then None else direction) }
          in Just { control | spec = String newSpec }

    Nothing -> Nothing

findItem : Dict String { a | key: Char } -> String -> Dict String { a | key: Char }
findItem dict key = Dict.filter (\_ item -> String.fromChar item.key == key) dict
