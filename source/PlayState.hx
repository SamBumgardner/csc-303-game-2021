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

		doors = new FlxTypedGroup<Door>();
		door = new Door(50, 50);
		doors.add(door);
		door = new Door(250, 250);
		doors.add(door);
		add(doors);

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
		if(FlxObject.updateTouchingFlags(hero, doors))
			{
				if(totalKeys.getKey() > 1)
					{
						totalKeys.useKeys();
						doors.open();
					}
			}
		if(FlxObject.updateTouchingFlags(hero, keys))
			{
				totalKeys.pickup();
				keys.pickup();
			}
		FlxG.collide(hero, doors);
		
		super.update(elapsed);
	}
}
