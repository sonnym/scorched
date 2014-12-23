import Signal (Signal, map)
import Graphics.Element (Element)

import Scorched.Model as Model

main : Signal Element
main = map Model.scene Model.state
