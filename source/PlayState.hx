package;


import flixel.FlxCamera.FlxCameraFollowStyle;
import environment.LevelExit;
import states.GameOverState;
import actors.enemies.DragonBoss;
import actors.enemies.Projectile;
import actors.enemies.KnightEnemy;
import actors.enemies.SlimeEnemy;
import flixel.util.FlxColor;
import actors.enemies.BatEnemy;
import flixel.FlxG;
import actors.enemies.Enemy;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
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

	private var map:FlxOgmo3Loader;
	private var walls:FlxTilemap;
	private var ending:Bool;
	private var won:Bool;

	private var levelExit:LevelExit;

	override public function create():Void
	{
		instantiateEntities();
		setUpLevel();
		addEntities();

		Enemy.WALLS = walls;
		Enemy.TARGETS.add(hero);

		FlxG.camera.follow(hero, FlxCameraFollowStyle.TOPDOWN, 1);
		FlxG.camera.zoom = 2;

		super.create();

/*
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
*/
		
	}

	private function setUpLevel():Void {
		map = new FlxOgmo3Loader(AssetPaths.csc303_game_levels__ogmo, AssetPaths.level01__json);
		walls = map.loadTilemap(AssetPaths.wallTile__png, "walls");
		walls.follow();
		walls.setTileProperties(1, FlxObject.NONE);
		walls.setTileProperties(2, FlxObject.ANY);

		map.loadEntities(placeEntities, "entities");
	}

	override public function update(elapsed:Float):Void
	{
		// Checks if hero is collideing with doors or keys
		super.update(elapsed);

		if (ending)
			{
				return;
			}

		if (FlxG.overlap(hero, levelExit))
			{
				ending = true;
				won = true;
				FlxG.camera.fade(FlxColor.BLACK, 0.33, false, doneFadeOut);
			}
		// Check enemy overlap
		FlxG.overlap(hero, enemies, Enemy.handleOverlap);
		FlxG.overlap(hero, KnightEnemy.SWORDS, Projectile.doDamage);
		FlxG.overlap(hero, DragonBoss.FIREBALLS, Projectile.doDamage);

		FlxG.overlap(hero, doors, openDoor);
		FlxG.overlap(hero, keys, pickupKey);
		FlxG.collide(hero, walls);
		FlxG.collide(hero, doors);
	}

	private function doneFadeOut()
	{
		FlxG.switchState(new states.GameOverState());	
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

	private function instantiateEntities():Void {
		levelExit = new LevelExit(270, 430);
		totalKeys = new TotalKeys();
		enemies = new FlxTypedGroup<Enemy>();
		hero = new Hero();
	}

	/**
	 * Helper function that adds all starting objects to the Scene.
	 */
	private function addEntities():Void {
		//add environment
		add(walls);
		add(levelExit);
		// add actors
		add(hero);
    	add(enemies);
    	addEnemies();
		add(hero);
		add(KnightEnemy.SWORDS);
		add(DragonBoss.FIREBALLS);
	}

	/*
	 * Added to test movement and loading of enemies
	 */
  	private function addEnemies() {
		/*for (val in 0...2) {
			enemies.add(new BatEnemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500)));
		}
		for (val in 0...2) {
			enemies.add(new SlimeEnemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500)));
		}
		for (val in 0...2) {
			enemies.add(new KnightEnemy(FlxG.random.int(100, 300), FlxG.random.int(200, 500)));
		}
		*/
		enemies.add(new DragonBoss(75, 350));
	}

	// places hero in correct spawn position
	private function placeEntities(entity:EntityData) {
		if (entity.name == "hero")
			{
				hero.setPosition(entity.x, entity.y);
			}
	}
}
