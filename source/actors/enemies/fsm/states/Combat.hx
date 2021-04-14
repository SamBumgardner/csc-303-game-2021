package actors.enemies.fsm.states;

class CombatState extends EnemyState {


    public function new(enemy:Enemy) {
        super(enemy);
    }

    override public function handleState():Int {
        if (!managedEnemy.targetFound()) {
            return EnemyStates.IDLE;
        }
        return super.handleState();
    }

    override public function update(elapsed:Float) {
        managedEnemy.animation.play(Enemy.ATTACK);
        if (managedEnemy.getAttackTimer() <= 0) {
            managedEnemy.attack();
            managedEnemy.resetAttackTimer();
        } else {
            managedEnemy.decrementAttackTimer(elapsed);
        }
    }
}