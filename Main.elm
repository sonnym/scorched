import Graphics.Element (Element)

import Scorched.View.Menu (renderMenu)
import Scorched.View.GamePlay (renderWorld)

import Scorched.Model.World as World
import Scorched.Model.Window as Window

main : Element
main = renderMenu Window.dimensions
-- main = renderWorld (World.default dimensions) dimensions
