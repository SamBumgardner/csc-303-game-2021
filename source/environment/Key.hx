package environment;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Key extends FlxSprite
{
    // Size of door
    public static var WIDTH(default, never):Int = 25;
    public static var HEIGHT(default, never):Int = 25;

    // If door is opened or not
    public var bossPickup:Bool = false;

    public function new(X:Float, Y:Float) 
    {
        super(X, Y);
        initializeGraphics();
    }
    
    private function initializeGraphics():Void 
    {
        makeGraphic(WIDTH, HEIGHT, FlxColor.BLUE);
    }
    
    override function update(elapsed:Float) 
    {
        super.update(elapsed);
    }

    public function pickup()
    {
        kill();
    }
}