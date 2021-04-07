package actors.enemies;

import flixel.math.FlxVector;

class BatEnemy extends Enemy {

    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 32;
    private static var HIT_BOX_WIDTH(default, never):Float = 20;
    private static var HIT_BOX_HEIGHT(default, never):Float = 20;
    private static var OFFSET_X(default, never):Float = 6;
    private static var OFFSET_Y(default, never):Float = 6;
    private static var HEALTH(default, never):Float = 1;
    public static var ATTACK_SPEED(default, never):Float = 2;

    public static var DAMAGE(default, never):Float = 1;

    public function new(X:Float, Y:Float) {
        super(X, Y, REGULAR, WIDTH, HEIGHT, HIT_BOX_WIDTH, HIT_BOX_HEIGHT, OFFSET_X, OFFSET_Y, HEALTH);
        addAnimations();
        attackTimer = 0;
    }

    /**
	 * Helper function that initializes the graphics and scale the sprite.
     * @author Matt Lippelman
	 */
    private override function initializeGraphics():Void {
        loadGraphic(AssetPaths.Bat__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        setGraphicSize(WIDTH * 2, HEIGHT * 2);
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

    override public function attack(elapsed:Float) {
        if (attackTimer <= 0) {
            velocity.set(0,0);
            var direction:FlxVector = getJumpDirection();
            moveTo(direction);
            attackTimer = ATTACK_SPEED;
        } else {
            attackTimer -= elapsed;
        }
    }

    private function getJumpDirection():FlxVector {
        var targetVector:FlxVector = FlxVector.weak(playerPosition.x - this.x, playerPosition.y - this.y);
        var radians:Float = FlxVector.weak(1, 0).radiansBetween(targetVector);
        var direction:FlxVector = FlxVector.weak(1, 0);
        if (playerPosition.y < this.y) {
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