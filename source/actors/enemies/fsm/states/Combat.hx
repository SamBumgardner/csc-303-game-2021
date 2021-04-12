package actors.enemies.fsm.states;

class CombatState extends EnemyState {


    public function new(enemy:Enemy) {
        super(enemy);
    }

    override public function update(elapsed:Float) {
        managedEnemy.attack(elapsed);
    }
}