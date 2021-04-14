package actors.player;

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
        for (val in 0...countLiving()) {
            var heart:HeartContainer = members[val];
            if (currentHealth >= HeartContainer.MAX_FRAG_AMOUNT) {
                currentHealth -= HeartContainer.MAX_FRAG_AMOUNT;
                heart.setFragments(HeartContainer.MAX_FRAG_AMOUNT);
            } else {
                heart.setFragments(Std.int(currentHealth));
                break;
            }
        }
    }
}