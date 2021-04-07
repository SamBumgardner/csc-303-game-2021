package actors.enemies;

import flixel.FlxSprite;
import actors.player.Hero;
import flixel.math.FlxVector;
import flixel.math.FlxPoint;

class Projectile extends FlxSprite {

    private var speed:Float;
    private var direction:FlxVector;

    public function new(?X:Float=0, ?Y:Float=0, speed:Float):Void {
        super(X,Y);
        loadGraphic(AssetPaths.KnightProjectile__png);
        this.speed = speed;
    }

    /**
	 * Sets the direction of travel given a spawn point and a target point. This function also
     * rotates the graphic to the corresponding agnle and sets the spawn point for the projectile.
     * @author Matt Lippelman
     * @param target the coordinate of the target to fire to
     * @param spawnPoint the coordinate to spawn the projectile from
     * @param additionalRadians radians to add to the angle of the projectile
     * @return void
	 */
    public function setDirection(target:FlxPoint, spawnPoint:FlxPoint, ?additionalRadians:Float = 0):Void {
        this.x = spawnPoint.x;
        this.y = spawnPoint.y;
        var targetVector:FlxVector = FlxVector.weak(target.x - spawnPoint.x, target.y - spawnPoint.y);
        var radians:Float = FlxVector.weak(1, 0).radiansBetween(targetVector);
        direction = FlxVector.weak(1, 0);
        if (target.y < spawnPoint.y) {
            radians = -radians;
        }
        direction.rotateByRadians(radians + additionalRadians);
        direction.normalize();
        this.angle = (radians + additionalRadians) * 180 / Math.PI + 180;
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if (!isOnScreen()) {
            kill();
        }
    }

    override public function reset(X:Float, Y:Float):Void {
        super.reset(X, Y);
    }

    /**
	 * This function fires the projectile in the direction stored.
     * @author Matt Lippelman
     * @return void
	 */
    public function fire():Void {
        if (!direction.isZero()) {
            velocity = direction.scale(speed);
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
     * @param projectile the projectile overlapping the player
     * @return void
	 */
    public static function doDamage(player:Hero, projectile:Projectile) {
        if (player.alive && player.exists && projectile.alive && projectile.exists) {
            var damage:Float = Std.is(projectile, Fireball) ? DragonBoss.DAMAGE : KnightEnemy.DAMAGE;
            player.hurt(damage);
            projectile.kill();
        }
    }
}