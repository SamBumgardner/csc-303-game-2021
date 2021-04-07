package actors.enemies.fsm.states;

import flixel.math.FlxPoint;
import flixel.FlxG;

class IdleState extends EnemyState {

    private var idleTimer:Float;
    private var moveDirection:Float;

    public function new(enemy:Enemy) {
        idleTimer = 0;
        super(enemy);
    }

    override public function update(elapsed:Float) {
        if (managedEnemy.type == REGULAR) {
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
    }
}