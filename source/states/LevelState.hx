package states;

import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.FlxState;

class LevelState extends FlxState 
{
    function createLevel() 
        {
            final map = new TiledMap("assets/data/level1.tmx");
            final wallsLayer:TiledObjectLayer = cast(map.getLayer("walls"));
        }
}