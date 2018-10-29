module Scorched.Model.World exposing (empty)

import Scorched.Model.Types exposing (World, Sky(..), Terrain)

import Scorched.Model.Sky as Sky
import Scorched.Model.Terrain as Terrain

empty : World
empty = { sky=Sky.empty, terrain=Terrain.empty }
