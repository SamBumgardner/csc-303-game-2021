package;

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
	private var doors:FlxTypedGroup<Door>;
	private var door:Door;
	private var keys:FlxTypedGroup<Key>;
	private var key:Key;
	private var totalKeys:TotalKeys;

	override public function create():Void
	{
		super.create();
		hero = new Hero();
		add(hero);

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
	}

	override public function update(elapsed:Float):Void
	{
		// Checks if hero is collideing with doors or keys
		FlxG.overlap(hero, doors, openDoor);
		FlxG.overlap(hero, keys, pickupKey);
		FlxG.collide(hero, doors);
		
		super.update(elapsed);
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
}
