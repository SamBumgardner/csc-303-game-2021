package actors.enemies;

class SwordProjectile extends Projectile {

    public static var SPEED:Float = 140;
    
    private static var WIDTH:Int = 16;
    private static var HEIGHT:Int = 16;
    private static var OFFSET_X:Float = 8;
    private static var OFFSET_Y:Float = 8;
    private static var DAMAGE:Float = 2;

    public function new(?X:Float=0, ?Y:Float=0):Void {
        super(X,Y, SPEED, DAMAGE);
        loadGraphic(AssetPaths.KnightProjectile__png);
        width = WIDTH;
        height = HEIGHT;
        offset.x = OFFSET_X;
        offset.y = OFFSET_Y;
    }
}