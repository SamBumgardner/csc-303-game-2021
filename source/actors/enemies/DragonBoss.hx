package actors.enemies;

import flixel.FlxObject;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;

class DragonBoss extends Enemy {

    private static var WIDTH(default, never):Int = 64;
    private static var HEIGHT(default, never):Int = 64;
    private static var HIT_BOX_WIDTH(default, never):Float = 40;
    private static var HIT_BOX_HEIGHT(default, never):Float = 40;
    private static var OFFSET_X(default, never):Float = 8;
    private static var OFFSET_Y(default, never):Float = 8;
    private static var HEALTH(default, never):Float = 8;

    public static var FIREBALLS(default, never):FlxTypedGroup<Fireball> = new FlxTypedGroup<Fireball>();

    public function new(X:Float, Y:Float, ?damage:Float=0, ?attackRange:Float=150, ?attackSpeed:Float=1) {
        super(X, Y, BOSS, WIDTH, HEIGHT, HIT_BOX_WIDTH, HIT_BOX_HEIGHT, OFFSET_X, OFFSET_Y, HEALTH);
        addAnimations();
        attackTimer = 0;
        this.damage = damage;
        this.attackSpeed = attackSpeed;
        this.attackRange = attackRange;
        this.immovable = true;
    }

    private override function initializeGraphics():Void {
        loadGraphic(AssetPaths.DragonBoss__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        width = HIT_BOX_WIDTH;
        height = HIT_BOX_HEIGHT;
    }

    private function addAnimations():Void {
        animation.add(Enemy.DOWN, [0, 1], 6, true);
        animation.add(Enemy.LEFT_RIGHT, [0, 1], 6, true);
        animation.add(Enemy.UP, [0,1], 6, true);
        animation.add(Enemy.ATTACK, [0,2,3], 6, true);
        animation.add(Enemy.TAKING_DAMAGE, [0, 4, 0], 6, false);
    }

    override public function attack() {
        var fireball_x_offset:Float = -25;
        if (targetPosition.x > this.x) {
            this.facing = FlxObject.RIGHT;
            fireball_x_offset = - fireball_x_offset;
        } else {
            this.facing = FlxObject.LEFT;
        }
        var fireball:Fireball = FIREBALLS.recycle(Fireball);
        fireball.setDirection(targetPosition, new FlxPoint(this.x + fireball_x_offset, this.y - 15));
        fireball.fire();
    }
}