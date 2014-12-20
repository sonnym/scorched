import Graphics.Element (Element)

import Scorched.View.Menu (renderMenu)
import Scorched.View.GamePlay (renderWorld)

import Scorched.Model.World as World

dimensions = {width=1024, height=768}

main : Element
main = renderWorld (World.default dimensions) dimensions
