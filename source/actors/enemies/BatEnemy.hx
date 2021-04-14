package actors.enemies;

import flixel.math.FlxVector;

class BatEnemy extends Enemy {

    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 32;
    private static var HIT_BOX_WIDTH(default, never):Float = 12;
    private static var HIT_BOX_HEIGHT(default, never):Float = 12;
    private static var OFFSET_X(default, never):Float = 10;
    private static var OFFSET_Y(default, never):Float = 10;
    private static var HEALTH(default, never):Float = 1;

    public function new(X:Float, Y:Float, ?damage:Float=1, ?attackRange:Float=120, ?attackSpeed:Float=2) {
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
        loadGraphic(AssetPaths.Bat__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        width = HIT_BOX_WIDTH;
        height = HIT_BOX_HEIGHT;
    }

    /**
	 * Helper function to add animations
     * @author Matt Lippelman
	 */
    private function addAnimations() {
        animation.add(Enemy.DOWN, [0, 1], 6, true);
        animation.add(Enemy.LEFT_RIGHT, [0, 1], 6, true);
        animation.add(Enemy.UP, [0, 1], 6, true);
        animation.add(Enemy.ATTACK, [0, 3, 4], 6, false);
        animation.add(Enemy.TAKING_DAMAGE, [0, 2], 6, true);
    }

    override public function attack() {
        velocity.set(0,0);
        var direction:FlxVector = getJumpDirection();
        moveTo(direction);
    }

    private function getJumpDirection():FlxVector {
        var targetVector:FlxVector = FlxVector.weak(targetPosition.x - this.x, targetPosition.y - this.y);
        var radians:Float = FlxVector.weak(1, 0).radiansBetween(targetVector);
        var direction:FlxVector = FlxVector.weak(1, 0);
        if (targetPosition.y < this.y) {
            radians = -radians;
        }
        direction.rotateByRadians(radians);
        direction.normalize();
        return direction;
    }

    private function moveTo(direction:FlxVector):Void {
        if (!direction.isZero()) {
            velocity = direction.scale(Enemy.SPEED / 2);
            velocity.x = Math.floor(velocity.x);
            velocity.y = Math.floor(velocity.y);
        }
    }
}