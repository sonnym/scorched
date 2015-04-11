module Scorched.View.Palette where

import Color exposing (Color, rgb, toRgb)

background = rgb 182 182 182

shadowDark = rgb 20 20 20
shadowLight = rgb 60 60 60

highlightDark = rgb 223 223 223
highlightLight = rgb 255 255 255

cyan = rgb 40 255 255

gradient : Color -> Color -> Int -> List Color
gradient start end steps =
  let
    startComponents = toRgb start
    endComponents = toRgb end

    differences = {
      red = (endComponents.red - startComponents.red) // steps,
      green = (endComponents.green - startComponents.green) // steps,
      blue = (endComponents.blue - startComponents.blue) // steps
    }
  in
    List.map
      (\i ->
        rgb (startComponents.red + (differences.red * i))
            (startComponents.green + (differences.green * i))
            (startComponents.blue + (differences.blue * i)))
      [0..(steps - 1)]
