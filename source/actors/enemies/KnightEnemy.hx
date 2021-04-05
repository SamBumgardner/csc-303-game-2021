package actors.enemies;

class KnightEnemy extends Enemy {

    public static var WIDTH(default, never):Int = 32;
    public static var HEIGHT(default, never):Int = 32;
    public static var HIT_BOX_WIDTH(default, never):Float = 16;
    public static var HIT_BOX_HEIGHT(default, never):Float = 16;
    public static var OFFSET_X(default, never):Float = 0;
    public static var OFFSET_Y(default, never):Float = 0;
    public static var HEALTH(default, never):Float = 1;

    public function new(X:Float, Y:Float) {
        super(X, Y, REGULAR, WIDTH, HEIGHT, HIT_BOX_WIDTH, HIT_BOX_HEIGHT, OFFSET_X, OFFSET_Y, HEALTH);
        addAnimations();
    }

    /**
	 * Helper function that initializes the graphics and scale the sprite.
     * @author Matt Lippelman
	 */
    private override function initializeGraphics():Void {
        loadGraphic(AssetPaths.Knight__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        setGraphicSize(WIDTH * 2, HEIGHT * 2);
    }

    /**
	 * Helper function to add animations
     * @author Matt Lippelman
	 */
    private function addAnimations():Void {
        animation.add(Enemy.DOWN, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.LEFT_RIGHT, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.UP, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.ATTACK, [0, 4, 0], 6, false);
    }
}