package environment;

import flixel.FlxSprite;

class TotalKeys extends FlxSprite
{
    public var keys:Int = 0;
    public var bossKey:Int = 0;


    public function new() 
        {
            super();
        }

    override function update(elapsed:Float) 
        {
            super.update(elapsed);
        }

    // Adds to number of keys hero is carrying
    public function pickup()
        {
            keys = keys + 1;
        }

    // Takes away key when used
    public function useKeys()
        {
            keys = keys - 1;
        }

    // get number of keys
    public function getKey()
        {
            return keys;
        }
}