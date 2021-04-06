package actors.enemies;

class SlimeEnemy extends Enemy {

    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 32;
    private static var HIT_BOX_WIDTH(default, never):Float = 16;
    private static var HIT_BOX_HEIGHT(default, never):Float = 16;
    private static var OFFSET_X(default, never):Float = 0;
    private static var OFFSET_Y(default, never):Float = 0;
    private static var HEALTH(default, never):Float = 2;

    public function new(X:Float, Y:Float) {
        super(X, Y, REGULAR, WIDTH, HEIGHT, HIT_BOX_WIDTH, HIT_BOX_HEIGHT, OFFSET_X, OFFSET_Y, HEALTH);
        addAnimations();
        attackTimer = 0;
        health = HEALTH;
    }

    /**
	 * Helper function that initializes the graphics and scale the sprite.
     * @author Matt Lippelman
	 */
    private override function initializeGraphics():Void {
        loadGraphic(AssetPaths.Slime__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        setGraphicSize(WIDTH * 2, HEIGHT * 2);
    }

    /**
	 * Helper function to add animations
     * @author Matt Lippelman
	 */
    private function addAnimations() {
        animation.add(Enemy.DOWN, [0, 1], 6, false);
        animation.add(Enemy.LEFT_RIGHT, [0, 1], 6, false);
        animation.add(Enemy.UP, [0, 1], 6, false);
    }

}