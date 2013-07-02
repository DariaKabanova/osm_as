/**
 * Created with IntelliJ IDEA.
 * User: madmoron
 * Date: 01.07.13
 * Time: 23:51
 * To change this template use File | Settings | File Templates.
 */
package {
public class CircleEnemy extends Circle {

    public function CircleEnemy(x:Number, y:Number, radius:int) {
        super(x, y, radius);
    }

    override public function changeSpeed(deltaSpeedX:Number, deltaSpeedY:Number):void {
        speed.x = deltaSpeedX;
        speed.y = deltaSpeedY;
    }

    override public function motion():void {
        var lx:Number, ly:Number;
        var deceleration:Number = 0.0001;

        lx = speed.x / Math.exp(deceleration) / radius;
        ly = speed.y / Math.exp(deceleration) / radius;

        hitTheWall(lx + center.x, ly + center.y);
    }
}

}
