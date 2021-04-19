package actors.enemies.fsm;

interface State {
    public function update(elapsed:Float):Void;
    public function handleState():Int;
    public function transitionIn():Void;
    public function transitionOut():Void;
}