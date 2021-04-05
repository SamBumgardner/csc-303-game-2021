package actors.player;

import flixel.FlxG;
import flixel.FlxSprite;

class Item extends FlxSprite 
{
    public var sWidth(default, never):Int = 50;
    public var sHeight(default, never):Int = 10;

    // 0 = right, 1 = down, 2 = left, 3 = up
    private var lastUsed:Int = 0;    

    public function new() {
        super();
    }
    override public function update(elapsed:Float):Void
        {
            if(FlxG.keys.pressed.RIGHT)
                {
                    lastUsed = 0;
                }
            else if(FlxG.keys.pressed.DOWN)
                {
                    lastUsed = 1;
                }
            else if(FlxG.keys.pressed.LEFT)
                {
                    lastUsed = 2;
                }
            else if(FlxG.keys.pressed.UP)
                {
                    lastUsed = 3;
                }
        }

    public function useItem()
    {
        if(lastUsed == 0)
            {
                angle = 0;
                makeGraphic(50, 10);
            }
        else if(lastUsed == 1)
            {
                angle = 0;
                makeGraphic(10, 50);
            }
        else if(lastUsed == 2)
            {
                x -= 50;
                angle = 180;
                makeGraphic(50, 10);
            }
        else if(lastUsed == 3)
            {
                y -= 50;
                angle = 180;
                makeGraphic(10, 50);
            }
    }

    public function swing()
        {
            makeGraphic(1,1);
        }
}