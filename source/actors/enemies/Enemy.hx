package actors.enemies;


import flixel.FlxG;
import actors.enemies.fsm.states.Combat.CombatState;
import actors.enemies.fsm.states.Idle.IdleState;
import actors.enemies.fsm.EnemyStates;
import actors.enemies.fsm.State;
import flixel.util.FlxColor;
import actors.player.Hero;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.FlxSprite;
import haxe.ds.Vector;

enum EnemyType {
    REGULAR;
    BOSS;
}

class Enemy extends FlxSprite {

    public static var SPEED:Float = 140;

    private static var DRAG:Float = 8;
    private static var ATTACK_RANGE:Float = 120;
    private static var BOSS_ATTACK_RANGE:Float = 250;

    // Animation strings
    public static var LEFT_RIGHT:String = "lr";
    public static var UP:String = "u";
    public static var DOWN:String = "d";
    public static var ATTACK:String = "attack";
    public static var TAKING_DAMAGE:String = "taking damage";

    public var type(default, null):EnemyType;
    public var playerPosition:FlxPoint;
    public var seesPlayer:Bool;

    private var spriteWidth:Int;
    private var spriteHeight:Int;
    private var justTookDamage:Bool = false;
    private var attackTimer:Float;
    private var state:State;
    private var states:Vector<State> = new Vector<State>(2);

    public function new(X:Float, Y:Float, type:EnemyType, spriteWidth:Int, spriteHeight:Int, width:Float, height:Float, offsetX:Float, offsetY:Float, health:Float) {
        super(X,Y);
        this.type = type;
        this.spriteWidth = spriteWidth;
        this.spriteHeight = spriteHeight;
        this.width = width;
        this.height = height;
        this.offset.x = offsetX;
        this.offset.y = offsetY;
        this.health = health;
        drag.x = drag.y = DRAG;
        setFacingFlip(FlxObject.LEFT, false, false);
        setFacingFlip(FlxObject.RIGHT, true, false);
        initializeGraphics();
        setupFSM();
        attackTimer = 0;
    }

    /**
	 * Helper function to setup the finite state machine and set initial state
     * @author Matt Lippelman
	 */
    private function setupFSM():Void {
        states[EnemyStates.IDLE] = new IdleState(this);
        states[EnemyStates.COMBAT] = new CombatState(this);

        state = states[EnemyStates.IDLE];
    }

    /**
	 * Helper function to initialize base graphics
     * @author Matt Lippelman
	 */
    private function initializeGraphics():Void {
        makeGraphic(spriteWidth, spriteHeight, FlxColor.RED);
    }

    override public function update(elapsed:Float):Void {
        if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE) {
            if (Math.abs(velocity.x) > Math.abs(velocity.y)) {
                if (velocity.x < 0) {
                    facing = FlxObject.LEFT;
                } else {
                    facing = FlxObject.RIGHT;
                }
            } else {
                if (velocity.y < 0) {
                    facing = FlxObject.UP;
                } else {
                    facing = FlxObject.DOWN;
                }
            }
        }

        if (justTookDamage) {
            animation.play(TAKING_DAMAGE);
            justTookDamage = false;
        }
        else if (state == states[EnemyStates.IDLE]) {
            switch (facing) {
                case FlxObject.LEFT, FlxObject.RIGHT:
                    animation.play(LEFT_RIGHT);

                case FlxObject.UP:
                    animation.play(UP);

                case FlxObject.DOWN:
                    animation.play(DOWN);
            }
            attackTimer -= elapsed;
        } else if (state == states[EnemyStates.COMBAT]) {
            animation.play(ATTACK);
        }

        state.update(elapsed);
        super.update(elapsed);
    }

    /**
	 * Function to check whether a Hero object is touching the Enemy object
     * @author Matt Lippelman
     * @param player the hero object touching the enemy
     * @param enemy the enemy object touching the enemy
     * @return void
	 */
    public static function playerTouchEnemy(player:Hero, enemy:Enemy):Void {
        if (player.alive && player.exists && enemy.alive && enemy.exists) {
            enemy.startCombat(player);
        }
    }

    /**
	 * Function to start combat with a player. This function will switch the enemy to COMBAT state and the 
     * enemy will begin attacking.
     * @author Matt Lippelman
     * @param player the hero object the enemy should attack
     * @return void
	 */
    private function startCombat(player:Hero):Void {
        velocity.set(0, 0);
        state = states[EnemyStates.COMBAT];
        trace("Hero is now in combat with enemy");
    }

    /**
	 * Override of FlxSprite hurt function.
     * @author Matt Lippelman
     * @param damageAmount an integer value in fragments (4 per heart) to be hurt the player
     * @return void
	 */
    override public function hurt(damageAmount:Float):Void {
        justTookDamage = true;
        super.hurt(damageAmount);
    }

    /**
	 * Override of FlxBasic kill function to display a death animation.
     * @author Matt Lippelman
     * @param damageAmount an integer value in fragments (4 per heart) to be hurt the player
     * @return void
	 */
    override public function kill() {
        //play the death animation
        super.kill();
    }

    /**
	 * This function is meant to be overriden by child classes. This function is called when
     * the enemy is in the Combat state
     * @author Matt Lippelman
     * @param elapsed the elapsed time
     * @return void
	 */
    public function attack(elapsed:Float):Void {
        trace("attack function not implemented");
    }

    /**
	 * This function will check to see if the player is within the attack range of an enemy.
     * If the player is in range, it will switch the enemy to Combat state.
     * @author Matt Lippelman
     * @param player the Hero object
     * @param enemy an enemy object to be checked
     * @return void
	 */
    public static function checkEnemyAttackRange(player:Hero, enemy:Enemy):Void {
        var playerMid:FlxPoint = player.getMidpoint();
        var enemyMid:FlxPoint = enemy.getMidpoint();
        var attackRange:Float = enemy.type == REGULAR ? ATTACK_RANGE : BOSS_ATTACK_RANGE;
        var distance:Float = Math.sqrt(Math.pow(playerMid.x - enemyMid.x,2) + Math.pow(playerMid.y - enemyMid.y, 2));
        if (Math.abs(distance) <= attackRange && enemy.seesPlayer) {
            enemy.playerPosition = playerMid;
            enemy.state = enemy.states[EnemyStates.COMBAT];
        } else {
            enemy.state = enemy.states[EnemyStates.IDLE];
        }
    }

    public static function handleOverlap(player:Hero, enemy:Enemy):Void {
        var damage:Float = 0;
        if (Std.is(enemy, SlimeEnemy)) {
            damage = SlimeEnemy.DAMAGE;
        } else if (Std.is(enemy, BatEnemy)) {
            damage = BatEnemy.DAMAGE;
        }

        trace(damage);
        if (player.alive && player.exists && enemy.alive && enemy.exists && enemy.attackTimer <= 0) {
            player.hurt(damage);
            enemy.attackTimer = Std.is(enemy, SlimeEnemy) ? SlimeEnemy.ATTACK_SPEED : (Std.is(enemy, BatEnemy) ? BatEnemy.ATTACK_SPEED : 5);
        }
        enemy.velocity.set(0,0);
    }
}