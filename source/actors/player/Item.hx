package actors.player;

import flixel.util.FlxTimer;
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
        makeGraphic(1,1);
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
            pos(owner.x + 12, owner.y + 12);

            super.update(elapsed);
        }

    public function useItem()
    {
        if(owner.facing == FlxObject.UP)
            {
                xMod = 0;
                yMod = -40;
                makeGraphic(10,50);
            }
        else if(owner.facing == FlxObject.DOWN)
            {
                xMod = 0;
                yMod = 0;
                makeGraphic(10,50);
            }
        else if(owner.facing == FlxObject.LEFT)
            {
                xMod = -40;
                yMod = 0;
                makeGraphic(50,10);
            }
        else if(owner.facing == FlxObject.RIGHT)
            {
                xMod = 0;
                yMod = 0;
                makeGraphic(50,10);
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