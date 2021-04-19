package actors.enemies.fsm;

@:enum
class EnemyStates {
    public static var NO_CHANGE(default, never):Int = -1;
    public static var IDLE(default, never):Int = 0;
    public static var COMBAT(default, never):Int = 1;
    public static var CHASE(default, never):Int = 2;
}