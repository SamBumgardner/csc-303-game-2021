package;

import actors.player.Hero;
import environment.Door;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var hero:Hero;
	private var door:Door;

	override public function create():Void
	{
		super.create();
		hero = new Hero();
		add(hero);
		door = new Door();
		add(door);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
