package actors.enemies.fsm.states;

import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.FlxObject;

class IdleState extends EnemyState {

    private var idleTimer:Float;
    private var moveDirection:Float;

    public function new(enemy:Enemy) {
        idleTimer = 0;
        super(enemy);
    }

    override public function handleState():Int {
        if (managedEnemy.targetFound()) {
            return EnemyStates.COMBAT;
        }
        return super.handleState();
    }

    override public function update(elapsed:Float):Void {
        if (managedEnemy.type == REGULAR) {
            switch (managedEnemy.facing) {
                case FlxObject.LEFT, FlxObject.RIGHT:
                    managedEnemy.animation.play(Enemy.LEFT_RIGHT);

                case FlxObject.UP:
                    managedEnemy.animation.play(Enemy.UP);

                case FlxObject.DOWN:
                    managedEnemy.animation.play(Enemy.DOWN);
            }

            if (idleTimer <= 0) {
                if (FlxG.random.bool(1)) {
                    moveDirection = -1;
                    this.managedEnemy.velocity.x = this.managedEnemy.velocity.y = 0;
                } else {
                    moveDirection = FlxG.random.int(0,8) * 45;

                    this.managedEnemy.velocity.set(Enemy.SPEED * 0.5, 0);
                    this.managedEnemy.velocity.rotate(FlxPoint.weak(), moveDirection);
                }
                idleTimer = FlxG.random.int(1, 4);
            } else {
                idleTimer -= elapsed;
            }
        }
        managedEnemy.decrementAttackTimer(elapsed);
    }
}