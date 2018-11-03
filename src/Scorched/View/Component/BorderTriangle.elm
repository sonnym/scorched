module Scorched.View.Component.BorderTriangle exposing (build)

import Svg exposing (Svg)
import Svg.Attributes as Attr
import Svg.Events as Events

import Scorched.Model.Types exposing (ControlSpec, Msg(..), Operation(..), Direction(..))
import Scorched.Model.Geometry exposing (Offset, Point)

import Scorched.View.Helper as Helper
import Scorched.View.Palette as Palette exposing (Color)

build : ControlSpec -> Bool -> Direction -> Offset -> String -> Svg Msg
build spec invert direction offset label =
  Svg.g
    [ Attr.class "bordertriangle", Attr.transform (Helper.translate offset) ]
    ((boundingBox spec direction label) :: (lines invert direction))

boundingBox : ControlSpec -> Direction -> String -> Svg Msg
boundingBox spec direction label =
  Svg.rect
    [ Attr.width "15"
    , Attr.height "10"
    , Attr.fillOpacity "0"
    , Events.onMouseDown (ControlToggle label direction)
    , Events.onMouseUp (ControlToggle label None)
    , Events.onClick (clickMsg direction spec)
    ] []

lines : Bool -> Direction -> List (Svg msg)
lines invert direction =
  case direction of
    Up -> List.map2 line upLines (upColors invert)
    Down -> List.map2 line downLines (downColors invert)
    None -> [ Svg.svg [] [] ]

line : (Point, Point) -> Color -> Svg msg
line (start, end) color =
  Svg.line
    [ Attr.x1 (String.fromInt start.x)
    , Attr.x2 (String.fromInt end.x)
    , Attr.y1 (String.fromInt start.y)
    , Attr.y2 (String.fromInt end.y)
    , Attr.strokeWidth "2"
    , Attr.stroke (Palette.toString color)
    ]
    []

upLines : List (Point, Point)
upLines = [ ({x=7, y=0}, {x=14, y=9})
          , ({x=14, y=9}, {x=0, y=9})
          , ({x=0, y=9}, {x=7, y=0})
          ]

downLines : List (Point, Point)
downLines = [ ({x=0, y=0}, {x=14, y=0})
            , ({x=14, y=0}, {x=7, y=9})
            , ({x=7, y=9}, {x=0, y=0})
            ]

upColors : Bool -> List Color
upColors invert =
  if invert then
    [ Palette.highlightLight, Palette.shadowDark, Palette.shadowDark ]
  else
    [ Palette.shadowDark, Palette.shadowLight, Palette.highlightLight ]

downColors : Bool -> List Color
downColors invert =
  if invert then
    [ Palette.highlightLight, Palette.highlightDark, Palette.shadowDark ]
  else
    [ Palette.highlightDark, Palette.shadowDark, Palette.highlightLight ]

clickMsg : Direction -> ControlSpec -> Msg
clickMsg direction spec =
  case direction of
    Up -> UpdateConfig Increment spec
    Down -> UpdateConfig Decrement spec
    None -> NoOp
