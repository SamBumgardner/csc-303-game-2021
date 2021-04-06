package actors.enemies.fsm.states;

class CombatState extends EnemyState {


    public function new(enemy:Enemy) {
        super(enemy);
    }

    override public function update(elapsed:Float) {
        this.managedEnemy.velocity.set(0, 0);
        managedEnemy.attack(elapsed);
    }
}