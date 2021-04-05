package;

import actors.enemies.KnightEnemy;
import actors.enemies.SlimeEnemy;
import flixel.util.FlxColor;
import actors.enemies.BatEnemy;
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
		bgColor =  FlxColor.fromString("0xababab");
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
			enemies.add(new BatEnemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500)));
		}
		for (val in 0...3) {
			enemies.add(new SlimeEnemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500)));
		}
		for (val in 0...3) {
			enemies.add(new KnightEnemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500)));
		}
	}
}
