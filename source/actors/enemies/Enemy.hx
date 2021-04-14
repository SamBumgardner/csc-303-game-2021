package actors.enemies;

import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
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
    public static var WALLS:FlxTilemap;
    public static var TARGETS:FlxTypedGroup<FlxObject> = new FlxTypedGroup<FlxObject>();

    private static var DRAG:Float = 8;


    // Animation strings
    public static var LEFT_RIGHT:String = "lr";
    public static var UP:String = "u";
    public static var DOWN:String = "d";
    public static var ATTACK:String = "attack";
    public static var TAKING_DAMAGE:String = "taking damage";

    public var type(default, null):EnemyType;
    public var targetPosition:FlxPoint;

    private var spriteWidth:Int;
    private var spriteHeight:Int;
    private var justTookDamage:Bool = false;
    private var attackTimer:Float;
    private var state:State;
    private var states:Vector<State> = new Vector<State>(2);
    private var damage:Float;
    private var attackRange:Float;
    private var attackSpeed:Float;

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

    public function getDamage():Float { return damage; }
    public function getAttackRange():Float { return attackRange; }
    public function getAttackSpeed():Float { return attackSpeed; }
    public function getAttackTimer():Float { return attackTimer; }
    public function resetAttackTimer():Void { attackTimer = attackSpeed; }
    public function decrementAttackTimer(value:Float):Void { attackTimer -= value; }

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
        applyTransitionStates();
        state.update(elapsed);

        super.update(elapsed);

        FlxG.collide(this, TARGETS);
        FlxG.collide(this, WALLS);
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
     * @return void
	 */
    public function attack():Void {
        trace("attack function not implemented");
    }

    /**
	 * This function will check to see if the player is within the attack range of an enemy.
     * If the player is in range, it will switch the enemy to Combat state.
     * @author Matt Lippelman
     * @return void
	 */
    public function isTargetInRange(target:FlxObject):Bool {
        var targetMid:FlxPoint = target.getMidpoint();
        var enemyMid:FlxPoint = getMidpoint();
        var distance:Float = Math.sqrt(Math.pow(targetMid.x - enemyMid.x,2) + Math.pow(targetMid.y - enemyMid.y, 2));
        if (Math.abs(distance) <= attackRange) {
            return true;
        } else {
            return false;
        }
    }

    public static function handleOverlap(player:Hero, enemy:Enemy):Void {
        if (enemy.attackTimer <= 0) {
            player.hurt(enemy.damage);
            enemy.resetAttackTimer();
        }
        enemy.velocity.set(0,0);
    }

    public function isTargetInVision(target:FlxObject):Bool {
        if (WALLS.ray(getMidpoint(), target.getMidpoint())) {
            return true;
        } else {
            return false;
        }
    }

    public function targetFound():Bool {
        for (target in TARGETS) {
            if (isTargetInRange(target) && isTargetInVision(target)) {
                targetPosition = target.getMidpoint();
                return true;
            }
        }
        targetPosition = null;
        return false;
    }

    private inline function applyTransitionStates():Void {
        var nextState:Int;
        do {
            nextState = state.handleState();
            if (nextState != EnemyStates.NO_CHANGE) {
                state.transitionOut();
                state = states[nextState];
                state.transitionIn();
            }
        } while (nextState != EnemyStates.NO_CHANGE);
    }
}