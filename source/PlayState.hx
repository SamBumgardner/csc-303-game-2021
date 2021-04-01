package;

import flixel.FlxG;
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
		if (FlxG.keys.justPressed.A) {
			hero.playerHealth.takeDamage(2);
		}
		if (FlxG.keys.justPressed.W) {
			hero.playerHealth.takeDamage(4);
		}
		if (FlxG.keys.justPressed.S) {
			hero.playerHealth.heal(1);
		}
		if (FlxG.keys.justPressed.D) {
			hero.playerHealth.heal(4);
		}
		if (FlxG.keys.justPressed.G) {
			hero.playerHealth.increaseMaxHealthByOneHeart();
		}
	}

	/**
	 * Helper function that adds all starting objects to the Scene.
	 */
	private function addEntities():Void {
		add(hero);
		add(hero.playerHealth.healthGraphicGroup);
	}
}
