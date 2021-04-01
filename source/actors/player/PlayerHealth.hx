package actors.player;

import flixel.group.FlxGroup;

class PlayerHealth {

    public var healthGraphicGroup(default, null):FlxTypedGroup<HeartContainer>;
    public var maxHealth(default, null):Int = 12;

    public function new() {
        initializeGraphics();
    }

    /**
	 * Helper function that initializes the heart graphics.
     * @author Matt Lippelman
	 */
    public function initializeGraphics():Void {
        healthGraphicGroup = new FlxTypedGroup<HeartContainer>();
        for (val in 0...Math.ceil(maxHealth / 4)) {
            healthGraphicGroup.add(new HeartContainer(val*32, 0, 4));
        }
    }

    /**
	 * Function to do damage to player.
     * @author Matt Lippelman
     * @param damage an integer value in fragments (4 per heart)
     * @return void
	 */
    public function takeDamage(damage:Int):Void {
        // cycle through hearts from end to beginning
        var i:Int = healthGraphicGroup.countLiving() - 1;
        while (i >= 0) {
            var heart:HeartContainer = healthGraphicGroup.members[i];
            // test if damage exceeds current value of the heart
            if (damage > heart.fragments) {
                // damage exceeds value of heart, damage heart and keep going
                damage -= heart.fragments;
                heart.takeDamage(heart.fragments);
                heart.updateGraphics();
            } else {
                // damage is less than value of heart, damage heart and break
                heart.takeDamage(damage);
                heart.updateGraphics();
                break;
            }
            i--;
        }

        if (isDead()) {
            trace("The player has died");
        }
    }

    /**
	 * Function to heal the player.
     * @author Matt Lippelman
     * @param amount an integer value in fragments (4 per heart) to heal the player
     * @return void
	 */
    public function heal(amount:Int):Void {
        for (val in 0...healthGraphicGroup.countLiving()) {
            var heart:HeartContainer = healthGraphicGroup.members[val];
            var missingFragments = HeartContainer.MAXFRAGAMOUNT - heart.fragments;
            if (missingFragments == 0) {
                continue;
            } else if (amount > missingFragments) {
                amount -= missingFragments;
                heart.heal(missingFragments);
                heart.updateGraphics();
            } else {
                heart.heal(amount);
                heart.updateGraphics();
                break;
            }
        }
    }

    /**
	 * Function to increase maximum health by one full heart container.
     * @author Matt Lippelman
     * @return void
	 */
    public function increaseMaxHealthByOneHeart():Void {
        increaseMaxHealth(4);
    }

    /**
	 * Function to increase maximum health of the player.
     * @author Matt Lippelman
     * @param fragments an integer value in fragments (4 per heart) to be added to max health
     * @return void
	 */
    public function increaseMaxHealth(fragments:Int):Void {
        maxHealth += fragments;
        healthGraphicGroup.add(new HeartContainer((healthGraphicGroup.countLiving()-1)*32, 0, fragments));
        fixGraphics();
    }

    /**
	 * Helper function to fix graphics after increasing max health.
     * @author Matt Lippelman
     * @return void
	 */
    private function fixGraphics():Void {

    }

    /**
	 * Function to return current health of the player. This value is in total fragments.
     * If total heart value is wanted, divide by 4.
     * @author Matt Lippelman
     * @return the current health of the player
	 */
    public function currentHealth():Int {
        var value:Int = 0;
        for (val in 0...healthGraphicGroup.countLiving()) {
            value += healthGraphicGroup.members[val].fragments;
            trace("Heart " + val + " has " + healthGraphicGroup.members[val].fragments + " fragments");
        }
        return value;
    }

    /**
	 * Function to check if player is dead.
     * @author Matt Lippelman
     * @return boolean value of whether or not the player is dead
	 */
    public function isDead():Bool {
        return healthGraphicGroup.members[0].fragments == 0;
    }
}