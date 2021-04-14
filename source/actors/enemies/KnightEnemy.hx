package actors.enemies;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;

class KnightEnemy extends Enemy {

    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 32;
    private static var HIT_BOX_WIDTH(default, never):Float = 16;
    private static var HIT_BOX_HEIGHT(default, never):Float = 20;
    private static var OFFSET_X(default, never):Float = 8;
    private static var OFFSET_Y(default, never):Float = 6;
    private static var HEALTH(default, never):Float = 2;

    public static var SWORDS(default, never):FlxTypedGroup<SwordProjectile> = new FlxTypedGroup<SwordProjectile>();

    public function new(X:Float, Y:Float, ?damage:Float=0, ?attackRange:Float=120, ?attackSpeed:Float=1.5) {
        super(X, Y, REGULAR, WIDTH, HEIGHT, HIT_BOX_WIDTH, HIT_BOX_HEIGHT, OFFSET_X, OFFSET_Y, HEALTH);
        addAnimations();
        attackTimer = 0;
        this.damage = damage;
        this.attackSpeed = attackSpeed;
        this.attackRange = attackRange;
    }

    /**
	 * Helper function that initializes the graphics and scale the sprite.
     * @author Matt Lippelman
	 */
    private override function initializeGraphics():Void {
        loadGraphic(AssetPaths.Knight__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        width = HIT_BOX_WIDTH;
        height = HIT_BOX_HEIGHT;
    }

    /**
	 * Helper function to add animations
     * @author Matt Lippelman
	 */
    private function addAnimations():Void {
        animation.add(Enemy.DOWN, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.LEFT_RIGHT, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.UP, [6, 7, 6, 8], 6, true);
        animation.add(Enemy.ATTACK, [0, 4, 0], 6, false);
        animation.add(Enemy.TAKING_DAMAGE, [0, 5, 0], 6, false);
    }

    override public function attack() {
        var sword:SwordProjectile = SWORDS.recycle(SwordProjectile);
        sword.setDirection(targetPosition, new FlxPoint(this.x, this.y));
        sword.fire();
    }
}