package actors.player;

import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;

class HeartContainer extends FlxSprite {

    private static var FULLHEART:String = "fullheart";
    private static var THREEQUARTERHEART:String = "threequarterheart";
    private static var HALFHEART:String = "halfheart";
    private static var ONEQUARTERHEART:String = "onequarterheart";
    private static var EMPTYHEART:String = "emptyheart";
    public static var MAXFRAGAMOUNT:Int = 4;

    public var fragments(default, null):Int;


    public function new(X:Float = 0, Y:Float = 0, fragments:Int) {
        super(X,Y);
        this.fragments = fragments;
        addAnimations();
        updateGraphics();
    }

    /**
	 * Helper function to add graphics for this heart.
     * @author Matt Lippelman
     * @return void
	 */
    private function addAnimations():Void {
        loadGraphic(AssetPaths.Heart_Spritesheet__png, true, 32, 32);

        animation.add(FULLHEART, [0], 1, false);
        animation.add(THREEQUARTERHEART, [1], 1, false);
        animation.add(HALFHEART, [2], 1, false);
        animation.add(ONEQUARTERHEART, [3], 1, false);
        animation.add(EMPTYHEART, [4], 1, false);
    }

    /**
	 * Function to update graphics for this heart.
     * @author Matt Lippelman
     * @return void
	 */
    public function updateGraphics():Void {
        switch (fragments) {
            case 4 : animation.play(FULLHEART);
            case 3 : animation.play(THREEQUARTERHEART);
            case 2 : animation.play(HALFHEART);
            case 1 : animation.play(ONEQUARTERHEART);
            default: animation.play(EMPTYHEART);
        }
    }

    /**
	 * Function to do damage to this heart container.
     * @author Matt Lippelman
     * @param damage an integer value in fragments (4 per heart)
     * @return void
	 */
    public function takeDamage(damage:Int):Void {
        if (damage > fragments) {
            fragments = 0;
        } else {
            fragments -= damage;
        }
    }

    /**
	 * Function to heal this heart container.
     * @author Matt Lippelman
     * @param amount an integer value in fragments (4 per heart) to heal this heart
     * @return void
	 */
    public function heal(amount:Int):Void {
        if (fragments + amount > MAXFRAGAMOUNT) {
            fragments = MAXFRAGAMOUNT;
        } else {
            fragments += amount;
        }
    }

    /**
	 * Function to set the fragment amount for this heart container.
     * @author Matt Lippelman
     * @param amount an integer value in fragments (4 per heart) to set this heart to
     * @return void
	 */
    public function setFragments(amount:Int):Void {
        if (amount > MAXFRAGAMOUNT) {
            fragments = MAXFRAGAMOUNT;
        } else {
            fragments = amount;
        }
        updateGraphics();
    }
}