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

    public function pickup()
        {
            keys = keys + 1;
        }
    public function useKeys()
        {
            keys = keys - 1;
        }
    public function getKey()
        {
            return keys;
        }
}