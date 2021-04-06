package;

import actors.enemies.SwordProjectile;
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
		hero = new Hero(0,32);
		enemies = new FlxTypedGroup<Enemy>();
		addEntities();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.overlap(hero, enemies, Enemy.playerTouchEnemy);
		FlxG.overlap(hero, KnightEnemy.SWORDS, SwordProjectile.doDamage);
		for (enemy in enemies) {
			if (enemy.alive) {
				Enemy.checkEnemyAttackRange(hero, enemy);
			}
		}
	}

	/**
	 * Helper function that adds all starting objects to the Scene.
	 */
	private function addEntities():Void {
		add(hero);
		add(hero.playerHealth);
    	add(enemies);
    	addEnemies();
		add(hero);
		add(KnightEnemy.SWORDS);
	}

	/*
	 * Added to test movement and loading of enemies
	 */
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
