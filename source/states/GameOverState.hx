package states;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAxes;

class GameOverState extends FlxState
{
    private var titleText:FlxText;
    private var playButton:FlxButton;
    

    override public function create()
        {
            titleText = new FlxText(0, 20, 0, "You Win!", 22);
            titleText.alignment = CENTER;
            titleText.screenCenter(FlxAxes.X);
            add(titleText);

            super.create();
        }
}
