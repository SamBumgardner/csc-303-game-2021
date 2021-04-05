package actors.player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;

class Item extends FlxSprite 
{
    private var up:Bool = false;
    private var down:Bool = false;
    private var left:Bool = false;
    private var right:Bool = false;
    var newAngle:Float = 0;
    var xMod:Float = 0;
    var yMod:Float = 0;

    public function new() {
        super();
        makeGraphic(1,1);
    }
    override public function update(elapsed:Float):Void
        {
            up = FlxG.keys.pressed.UP;
            down = FlxG.keys.pressed.DOWN;
            left = FlxG.keys.pressed.LEFT;
            right = FlxG.keys.pressed.RIGHT;

            if (up)
                {
                    newAngle = -90;
                    if (left)
                        newAngle -= 45;
                    else if (right)
                        newAngle += 45;
                    facing = FlxObject.UP;
                }
                else if (down)
                {
                    newAngle = 90;
                    if (left)
                        newAngle += 45;
                    else if (right)
                        newAngle -= 45;
                    facing = FlxObject.DOWN;
                }
                else if (left)
                {
                    newAngle = 180;
                    facing = FlxObject.LEFT;
                }
                else if (right)
                {
                    newAngle = 0;
                    facing = FlxObject.RIGHT;
                }
        }

    public function useItem()
    {
        if(newAngle == -90)
            {
                xMod = -21;
                yMod = -20;
            }
        else if(newAngle == -135)
            {
                xMod = -35;
                yMod = -15;
            }
        else if(newAngle == -45)
            {
                xMod = -5;
                yMod = -15;
            }
        else if(newAngle == 90)
            {
                xMod = -21;
                yMod = 15;
            }
        else if(newAngle == 45)
            {
                xMod = -5;
                yMod = 15;
            }
        else if(newAngle == 135)
            {
                xMod = -35;
                yMod = 15;
            }
        else if(newAngle == 180)
            {
                xMod = -40;
                yMod = 0;
            }

        angle = newAngle;
        makeGraphic(50,10);
        
    }

    public function swing()
        {
            makeGraphic(1,1);
            xMod = 0;
            yMod = 0;
        }

    public function pos(hX, hY)
        {
            x = hX + xMod;
            y = hY + yMod;
        }
}