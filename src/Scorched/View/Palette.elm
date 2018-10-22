module Scorched.View.Palette exposing (..)

import String exposing (fromInt)

type alias Color = { r: Int , g: Int , b: Int }

background : Color
background = { r = 182, g = 182, b = 182 }

toString : Color -> String
toString {r, g, b} =
  "rgb(" ++ fromInt r ++ ", " ++ fromInt g ++ ", " ++ fromInt b ++ ")"

shadowDark : Color
shadowDark = { r = 20, g = 20, b = 20 }

shadowLight : Color
shadowLight = { r = 60, g = 60, b = 60 }

highlightDark : Color
highlightDark = { r = 223, g = 223, b = 223 }

highlightLight : Color
highlightLight = { r = 255, g = 255, b = 255 }

sunset : List Color
sunset =
  [ { r = 52, g = 52, b = 150 }
  , { r = 60, g = 60, b = 162 }
  , { r = 69, g = 69, b = 174 }
  , { r = 77, g = 77, b = 190 }
  , { r = 85, g = 85, b = 203 }
  , { r = 89, g = 89, b = 215 }
  , { r = 101, g = 101, b = 227 }
  , { r = 109, g = 109, b = 239 }
  , { r = 117, g = 117, b = 255 }
  , { r = 130, g = 117, b = 235 }
  , { r = 142, g = 109, b = 219 }
  , { r = 158, g = 105, b = 203 }
  , { r = 170, g = 101, b = 182 }
  , { r = 199, g = 93, b = 150 }
  , { r = 255, g = 81, b = 81 }
  , { r = 251, g = 130, b = 56 }
  , { r = 255, g = 150, b = 48 }
  , { r = 255, g = 166, b = 40 }
  , { r = 255, g = 182, b = 32 }
  , { r = 255, g = 198, b = 24 }
  , { r = 255, g = 214, b = 16 }
  ]

{--
cyan = rgb 40 255 255
--}
