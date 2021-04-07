package actors.enemies;

class Fireball extends Projectile {
    
    public static var SPEED:Float = 120;

    private static var WIDTH:Int = 16;
    private static var HEIGHT:Int = 16;
    private static var OFFSET_X:Float = 0;
    private static var OFFSET_Y:Float = 0;

    public function new(?X:Float=0, ?Y:Float=0):Void {
        super(X,Y, SPEED);
        loadGraphic(AssetPaths.Fireball__png);
        width = WIDTH;
        height = HEIGHT;
        offset.x = OFFSET_X;
        offset.y = OFFSET_Y;
    }
}