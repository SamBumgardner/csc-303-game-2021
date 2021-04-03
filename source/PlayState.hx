package;

import actors.player.Hero;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var hero:Hero;

	override public function create():Void
	{
		super.create();
		hero = new Hero(0,32);
		addEntities();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	/**
	 * Helper function that adds all starting objects to the Scene.
	 */
	private function addEntities():Void {
		add(hero);
		add(hero.playerHealth);
	}
}
