package actors.player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxTimer;

class Item extends FlxSprite 
{
    private var owner:FlxSprite;
    private var timer:FlxTimer;

    private var xMod:Float = 0;
    private var yMod:Float = 0;
	private var time:FlxTimer;
    
    public function new(owner:FlxSprite) {
        super();
        makeGraphic(0,0);
        this.owner = owner;
        timer = new FlxTimer();
    }
    override public function update(elapsed:Float):Void
        {
            if(FlxG.keys.justPressed.A)
                {
                    useItem();
                    timer.start(0.2, swing, 1);
                }
            pos(owner.x + 6, owner.y);

            super.update(elapsed);
        }

    public function useItem()
    {
        if(owner.facing == FlxObject.UP)
            {
                xMod = 0;
                yMod = -15;
                makeGraphic(4,18);
            }
        else if(owner.facing == FlxObject.DOWN)
            {
                xMod = 0;
                yMod = 15;
                makeGraphic(4,18);
            }
        else if(owner.facing == FlxObject.LEFT)
            {
                xMod = -22;
                yMod = 6;
                makeGraphic(18,4);
            }
        else if(owner.facing == FlxObject.RIGHT)
            {
                xMod = 8;
                yMod = 6;
                makeGraphic(18,4);
            }       
    }

    public function pos(hX, hY)
        {
            x = hX + xMod;
            y = hY + yMod;
        }

    private function swing(timer:FlxTimer)
        {
            makeGraphic(1,1);
            xMod = 0;
            yMod = 0;
        }
}