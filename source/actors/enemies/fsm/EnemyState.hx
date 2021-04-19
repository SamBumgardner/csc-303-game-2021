package actors.enemies.fsm;

class EnemyState implements State {

    private var facing:Int;
    private var managedEnemy:Enemy;

    public function new(enemy:Enemy) {
        this.managedEnemy = enemy;
    }

    public function handleState():Int {
        return EnemyStates.NO_CHANGE;
    }

    public function update(elapsed:Float):Void {};

    public function transitionIn():Void {};

    public function transitionOut():Void {};
}