package environment;

import flixel.FlxSprite;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class LevelExit extends FlxSprite
{
    public static var WIDTH(default, never):Int = 40;
    public static var HEIGHT(default, never):Int = 40;

    public function new(X:Float, Y:Float) 
        {
            super(X, Y);
            immovable = true;
            initializeGraphics();
        }
    
        private function initializeGraphics():Void 
        {
            makeGraphic(WIDTH, HEIGHT, FlxColor.GREEN);
        }
    
        override function update(elapsed:Float) 
        {
            super.update(elapsed);
        }
}