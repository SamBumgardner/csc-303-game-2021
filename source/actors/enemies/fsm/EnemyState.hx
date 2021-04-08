package actors.enemies.fsm;

class EnemyState implements State {

    private var facing:Int;
    private var managedEnemy:Enemy;

    public function new(enemy:Enemy) {
        this.managedEnemy = enemy;
    }

    public function update(elapsed:Float):Void {};
}