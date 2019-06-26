module Scorched.Model.Control.Type exposing (updateConfig)

import List exposing (reverse, drop, head)
import Maybe exposing (withDefault)

import Scorched.Model.Types exposing (Operation(..), Configuration, Control, TypeSpec)

updateConfig : Configuration -> Operation -> TypeSpec -> Configuration
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
    first :: rest -> if first == current then head rest else findNext (drop 1 rest) current
    [] -> Nothing

ensure : List String -> String -> Maybe String -> String
ensure options current maybeNext =
  case maybeNext of
    Just next -> next
    Nothing ->
      case head options of
        Just first -> first
        Nothing -> current
