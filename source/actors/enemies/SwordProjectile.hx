package actors.enemies;

import haxe.ds.WeakMap;
import flixel.math.FlxPoint;
import actors.player.Hero;
import flixel.FlxObject;
import flixel.math.FlxVector;
import flixel.FlxSprite;

class SwordProjectile extends FlxSprite {

    public static var SPEED:Float = 140;
    
    private static var WIDTH:Int = 16;
    private static var HEIGHT:Int = 16;
    private static var OFFSET_X:Float = 8;
    private static var OFFSET_Y:Float = 8;

    private var direction:FlxVector;

    public function new(?X:Float=0, ?Y:Float=0):Void {
        super(X,Y);
        loadGraphic(AssetPaths.KnightProjectile__png);
        width = WIDTH;
        height = HEIGHT;
        offset.x = OFFSET_X;
        offset.y = OFFSET_Y;
    }

    /**
	 * Sets the direction of travel given a spawn point and a target point. This function also
     * rotates the graphic to the corresponding agnle and sets the spawn point for the projectile.
     * @author Matt Lippelman
     * @param target the coordinate of the target to fire to
     * @param spawnPoint the coordinate to spawn the projectile from
     * @return void
	 */
    public function setDirection(target:FlxPoint, spawnPoint:FlxPoint):Void {
        this.x = spawnPoint.x;
        this.y = spawnPoint.y;
        var targetVector:FlxVector = FlxVector.weak(target.x - spawnPoint.x, target.y - spawnPoint.y);
        var radians:Float = FlxVector.weak(1, 0).radiansBetween(targetVector);
        direction = FlxVector.weak(1,0);
        if (target.y < spawnPoint.y) {
            radians = -radians;
        }
        direction.rotateByRadians(radians);
        direction.normalize();
        this.angle = (radians) * 180 / Math.PI + 180;
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if (!isOnScreen()) {
            kill();
        }
    }

    override public function reset(X:Float, Y:Float):Void {
        super.reset(X,Y);
    }

    /**
	 * This function fires the projectile in the direction stored.
     * @author Matt Lippelman
     * @return void
	 */
    public function fire():Void {
        if (!direction.isZero()) {
            velocity = direction.scale(SPEED);
            velocity.x = Math.floor(velocity.x);
            velocity.y = Math.floor(velocity.y);
        } else {
            velocity.x = 0;
            velocity.y = 0;
        }
    }

    /**
	 * This function will damage the player when the projectile overlaps it
     * @author Matt Lippelman
     * @param player the Hero object of the game
     * @param sword the sword projectile overlapping the player
     * @return void
	 */
    public static function doDamage(player:Hero, sword:SwordProjectile):Void {
        if (player.alive && player.exists && sword.alive && sword.exists) {
            player.hurt(KnightEnemy.DAMAGE);
            sword.kill();
        }
    }
}