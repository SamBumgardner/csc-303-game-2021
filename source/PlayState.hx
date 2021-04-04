package;

import flixel.FlxG;
import actors.enemies.Enemy;
import flixel.group.FlxGroup;
import actors.player.Hero;
import flixel.FlxState;

class PlayState extends FlxState
{
	private var hero:Hero;
	private var enemies:FlxTypedGroup<Enemy>;

	override public function create():Void
	{
		super.create();
		hero = new Hero();
		add(hero);
		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
		addEnemies();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.overlap(hero, enemies, Enemy.playerTouchEnemy);
		super.update(elapsed);
	}

	private function addEnemies() {
		for (val in 0...5) {
			enemies.add(new Enemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500), REGULAR, 32, 32, 16, 16, 8, 8));
		}
	}
}
