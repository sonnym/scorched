import List
import Signal

import Color (..)
import Graphics.Element (..)
import Graphics.Collage (..)

dimensions = { width = 1024, height = 768 }

type alias Terrain = List Int

type alias World = {
  terrain: Terrain
}

main : Element
main = renderWorld defaultWorld

renderWorld : World -> Element
renderWorld { terrain } = collage dimensions.width dimensions.height (drawTerrain terrain)

drawTerrain : Terrain -> List Form
drawTerrain terrain = List.indexedMap drawLine terrain

drawLine : Int -> Int -> Form
drawLine x height = traced (solid black) (terrainLine height) |> moveX (toFloat x)

terrainLine : Int -> Path
terrainLine height = rect 1.0 (toFloat height)

defaultWorld : World
defaultWorld = { terrain = (List.repeat dimensions.width 500) }
