package;

import actors.player.Hero;
import actors.player.Item;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	private var hero:Hero;
	private var sword:Item;
	private var time:FlxTimer;

	override public function create():Void
	{
		super.create();
		hero = new Hero();
		add(hero);
		sword = new Item();
		add(sword);
		time = new FlxTimer();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		sword.x = hero.x + 12;
		sword.y = hero.y + 12;

		if (FlxG.keys.justPressed.A)
			{
				sword.useItem();
				time.start(0.2, onSwing, 1);
			}
	}

	

	 function onSwing(timer:FlxTimer)
		{
			sword.swing();
		}
}
