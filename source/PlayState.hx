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
import environment.Door;
import environment.TotalKeys;
import environment.Key;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;

class PlayState extends FlxState
{
	private var hero:Hero;
	private var enemies:FlxTypedGroup<Enemy>;
	private var doors:FlxTypedGroup<Door>;
	private var door:Door;
	private var keys:FlxTypedGroup<Key>;
	private var key:Key;
	private var totalKeys:TotalKeys;

	override public function create():Void
	{
		super.create();
		bgColor =  FlxColor.fromString("0xababab");

		// Add door objects
		doors = new FlxTypedGroup<Door>();
		door = new Door(50, 50);
		doors.add(door);
		door = new Door(250, 250);
		doors.add(door);
		add(doors);

		// Add key objects
		keys = new FlxTypedGroup<Key>();
		key = new Key(100, 100);
		keys.add(key);
		key = new Key(300, 300);
		keys.add(key);
		add(keys);

		totalKeys = new TotalKeys();
		hero = new Hero(0,32);
		enemies = new FlxTypedGroup<Enemy>();
		addEntities();
	}

	override public function update(elapsed:Float):Void
	{
		// Checks if hero is collideing with doors or keys
		super.update(elapsed);
		FlxG.overlap(hero, enemies, Enemy.playerTouchEnemy);
		FlxG.overlap(hero, KnightEnemy.SWORDS, SwordProjectile.doDamage);
		for (enemy in enemies) {
			if (enemy.alive) {
				Enemy.checkEnemyAttackRange(hero, enemy);
			}
		}
		FlxG.overlap(hero, doors, openDoor);
		FlxG.overlap(hero, keys, pickupKey);
		FlxG.collide(hero, doors);
	}

	// Opens locked doors if you have a key
	private function openDoor(hero:Hero, door:Door)
		{
			if(totalKeys.getKey() > 0)
				{
					totalKeys.useKeys();
					door.openDoor();
				}
		}

	// Picks up the Key
	private function pickupKey(hero:Hero, key:Key)
		{
			totalKeys.pickup();
			key.pickup();
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
