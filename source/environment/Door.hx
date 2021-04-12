package environment;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Door extends FlxSprite
{
    // Size of door
    public static var WIDTH(default, never):Int = 45;
    public static var HEIGHT(default, never):Int = 45;

    // If door is opened or not
    public var open:Bool = false;
    public var bossDoor:Bool = false;

    public function new(X:Float, Y:Float) 
    {
        super(X, Y);
        immovable = true;
        initializeGraphics();
    }

    private function initializeGraphics():Void 
    {
        makeGraphic(WIDTH, HEIGHT, FlxColor.RED);
    }

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
    }

    // kills object when player comes with a key
    public function openDoor():Void
    {
        kill();    
    }
}