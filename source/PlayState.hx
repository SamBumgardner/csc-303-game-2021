package;

import actors.player.Hero;
import actors.player.Item;
import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
	private var hero:Hero;
	private var sword:Item;

	override public function create():Void
	{
		super.create();
		hero = new Hero();
		add(hero);
		sword = new Item(hero);
		add(sword);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
