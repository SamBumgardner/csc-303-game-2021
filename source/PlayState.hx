package;

import actors.player.Hero;
import actors.player.Item;
import flixel.FlxState;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;

class PlayState extends FlxState
{
	private var hero:Hero;
	private var item:Item;

	override public function create():Void
	{
		super.create();
		hero = new Hero();
		add(hero);
		item = new Item();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.A)
			{
				add(item);
				item.useItem(hero.getX(), hero.getY());
			}
	}
}
