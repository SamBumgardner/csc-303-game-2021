package actors.player;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;

class PlayerHealth extends FlxTypedGroup<HeartContainer> {

    public var maxHealth(default, null):Int;

    public function new(maxHealth:Int = 12, maxSize:Int = 0) {
        super(maxSize);
        this.maxHealth = maxHealth;
        initializeGraphics();
    }

    /**
	 * Helper function that initializes the heart graphics.
     * @author Matt Lippelman
	 */
    private function initializeGraphics():Void {
        for(val in 0...Math.ceil(maxHealth / HeartContainer.MAX_FRAG_AMOUNT)) {
            add(new HeartContainer(val*HeartContainer.SPRITE_WIDTH, 5, HeartContainer.MAX_FRAG_AMOUNT));
        }
    }

    /**
	 * Function to increase maximum health of the player.
     * @author Matt Lippelman
     * @param fragments an integer value in fragments (4 per heart) to be added to max health
     * @param currentHealth the current health of the player
     * @return void
	 */
     public function increaseMaxHealth(fragments:Int, currentHealth:Float):Void {
        if (maxHealth % HeartContainer.MAX_FRAG_AMOUNT == 0) {
            add(new HeartContainer((maxHealth / HeartContainer.MAX_FRAG_AMOUNT) * HeartContainer.SPRITE_WIDTH, 0, 0));
        }
        maxHealth += fragments;
    }

    public function updateGraphics(currentHealth:Float):Void {
        for (val in 0...length) {
            var healthToDisplay:Float = currentHealth - val * HeartContainer.MAX_FRAG_AMOUNT;
            members[val].setFragments(Std.int(Math.max(healthToDisplay, 0)));
        }
    }

    /**
     * Set heart positions the passed in position, relative to the top-left corner of the camera.
     */
    public function resetPosition(X:Float = 0, Y:Float = 0):Void {
        for(i in 0...members.length) {
            
            members[i].x = X + i * HeartContainer.SPRITE_WIDTH;
            members[i].y = Y;
        }
    }

    override public function update(elapsed:Float) {
        if (!members[0].isOnScreen()) {
            var x = FlxG.width / 2 * ((FlxG.camera.zoom - 1) / FlxG.camera.zoom);
            var y = FlxG.height / 2 * ((FlxG.camera.zoom - 1) / FlxG.camera.zoom);
            trace(x, y);
            resetPosition(x, y);
        }
        super.update(elapsed);
    }
}