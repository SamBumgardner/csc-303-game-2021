package actors.player;

import flixel.math.FlxVector;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.keyboard.FlxKeyboard;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxSprite;

class Hero extends FlxSprite {

    public static var WIDTH(default, never):Int = 16;
    public static var HEIGHT(default, never):Int = 16;

    public static var BASE_MOVE_SPEED:Float = 200;

    public var playerHealth(default, null):PlayerHealth;

    // Controls
    private static var INPUT_LEFT:FlxKey = FlxKey.LEFT;
    private static var INPUT_RIGHT:FlxKey = FlxKey.RIGHT;
    private static var INPUT_UP:FlxKey = FlxKey.UP;
    private static var INPUT_DOWN:FlxKey = FlxKey.DOWN;

    private static var ACTION_1:FlxKey = FlxKey.Z;
    private static var ACTION_2:FlxKey = FlxKey.X;

    // Stats
    private static var STARTING_MAX_HEALTH:Int = 12; //This is total number of fragments, not total hearts

    public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
        playerHealth = new PlayerHealth(STARTING_MAX_HEALTH);
        health = STARTING_MAX_HEALTH;
        initializeGraphics();
    }

    private function initializeGraphics():Void {
        makeGraphic(WIDTH, HEIGHT);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        var moveDirection:FlxVector = selectMoveDirection();
        standardMovement(moveDirection);
    }

    private function selectMoveDirection():FlxVector {
        var horizontalDirection:Int = 0;
        var verticalDirection:Int = 0;
        var moveDirection:FlxVector = FlxVector.weak(0, 0);

        var keys:FlxKeyboard = FlxG.keys;
        var pressed = FlxInputState.PRESSED;

        keys.checkStatus(INPUT_LEFT, pressed) ? horizontalDirection-- : horizontalDirection;
        keys.checkStatus(INPUT_RIGHT, pressed) ? horizontalDirection++ : horizontalDirection;
        keys.checkStatus(INPUT_UP, pressed) ? verticalDirection-- : verticalDirection;
        keys.checkStatus(INPUT_DOWN, pressed) ? verticalDirection++ : verticalDirection;

        moveDirection.x = horizontalDirection;
        moveDirection.y = verticalDirection;
        if (!moveDirection.isZero()) {
            moveDirection.normalize();
        }

        return moveDirection;
    }

    private function standardMovement(moveDirection:FlxVector):Void {
        if (!moveDirection.isZero()) {
            velocity = moveDirection.scale(BASE_MOVE_SPEED);
            velocity.x = Math.floor(velocity.x);
            velocity.y = Math.floor(velocity.y);
            //trace(velocity);
        } else {
            velocity.x = 0;
            velocity.y = 0;
        }
    }

    /**
	 * Override of FlxSprite hurt function.
     * @author Matt Lippelman
     * @param damageAmount an integer value in fragments (4 per heart) to be hurt the player
     * @return void
	 */
    public override function hurt(damageAmount:Float):Void {
        super.hurt(damageAmount);
        playerHealth.updateGraphics(health);
    }

    /**
	 * Function to heal the player.
     * @author Matt Lippelman
     * @param healAmount an integer value in fragments (4 per heart) to be heal the player
     * @return void
	 */
    public function heal(healAmount:Int):Void {
        super.hurt(-healAmount);
        if (health >= playerHealth.maxHealth) {
            health = playerHealth.maxHealth;
        }
        playerHealth.updateGraphics(health);
    }

    /**
	 * Function to increase maximum health of the player.
     * @author Matt Lippelman
     * @param fragments an integer value in fragments (4 per heart) to be added to max health
     * @return void
	 */
    public function increaseMaxHealth(heartFragments:Int):Void {
        playerHealth.increaseMaxHealth(heartFragments, health);
        heal(heartFragments);
    }

    /**
	 * Function to increase maximum health by one full heart container.
     * @author Matt Lippelman
     * @return void
	 */
    public function increaseMaxHealthByOneHeart():Void {
        playerHealth.increaseMaxHealth(HeartContainer.MAX_FRAG_AMOUNT, health);
        heal(HeartContainer.MAX_FRAG_AMOUNT);
    }
}