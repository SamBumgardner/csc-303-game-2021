package environment;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class Door extends FlxSprite
{
    // Size of door
    public static var WIDTH(default, never):Int = 45;
    public static var HEIGHT(default, never):Int = 45;

    // If door is opened or not
    public var open:Bool = false;
    public var bossDoor:Bool = false;

    // How many keys the hero has to open doors
    public var key:Int = 1;
    public var bossKey:Int = 0;

    public function new(X:Float = 50, Y:Float = 50) 
    {
        super(X, Y);
        initializeGraphics();
    }

    private function initializeGraphics():Void 
    {
        makeGraphic(WIDTH, HEIGHT, FlxColor.RED);
    }

    //FlxG.collide(hero, door, openDoor);

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
    }

    private function openDoor():Void
    {

        if(open == false && key > 0)
            {
                open = true;
                key -= 1;
            }
        else if(open == false)
            {
                
            }
            
    }
}