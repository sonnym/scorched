module Scorched.Model.Control.String exposing (updateConfig)

import List exposing (reverse, head)
import Maybe exposing (withDefault)

import Scorched.Model.Types exposing (Operation(..), Config, Control, StringControlSpec)

updateConfig : Config -> Operation -> StringControlSpec -> Config
updateConfig config op {options, getter, setter} =
  let
    current = getter config
    list = case op of
      Increment -> options
      Decrement -> reverse options
  in
    (setter config (ensure list current (findNext list (getter config))))

findNext : List String -> String -> Maybe String
findNext options current =
  case options of
    first :: rest -> if first == current then head rest else findNext rest current
    [] -> Nothing

ensure : List String -> String -> Maybe String -> String
ensure options current maybeNext =
  case maybeNext of
    Just next -> next
    Nothing ->
      case head options of
        Just first -> first
        Nothing -> current
