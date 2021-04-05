package actors.enemies;


import flixel.system.FlxAssets.FlxGraphicAsset;
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

    // Animation strings
    public static var LEFT_RIGHT:String = "lr";
    public static var UP:String = "u";
    public static var DOWN:String = "d";
    public static var ATTACK:String = "attack";

    private var type:EnemyType;
    private var spriteWidth:Int;
    private var spriteHeight:Int;
    private var playerPosition:FlxPoint;

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
    }

    private function setupFSM():Void {
        states[EnemyStates.IDLE] = new IdleState(this);
        states[EnemyStates.COMBAT] = new CombatState(this);

        state = states[EnemyStates.IDLE];
    }

    private function initializeGraphics():Void {
        makeGraphic(spriteWidth, spriteHeight, FlxColor.RED);
    }

    override public function update(elapsed:Float) {
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

        switch (facing) {
            case FlxObject.LEFT, FlxObject.RIGHT:
                    animation.play(LEFT_RIGHT);

                case FlxObject.UP:
                    animation.play(UP);

                case FlxObject.DOWN:
                    animation.play(DOWN);
        }
        state.update(elapsed);
        super.update(elapsed);
    }

    public static function playerTouchEnemy(player:Hero, enemy:Enemy) {
        if (player.alive && player.exists && enemy.alive && enemy.exists) {
            enemy.startCombat(player);
        }
    }

    private function startCombat(player:Hero) {
        state = states[EnemyStates.COMBAT];
        trace("Hero is now in combat with enemy");
    }

    public override function hurt(damageAmount:Float):Void {
        super.hurt(damageAmount);
        //play damaged animation
    }
}