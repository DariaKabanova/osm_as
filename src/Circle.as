package {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;

public class Circle extends Sprite{

    protected var center:Point;
    protected var radius:int;
    protected var color:uint;
    protected var speedX:Number=0.0;
    protected var speedY:Number=0.0;

    public function Circle(x:int, y:int, radius:int) {
        center.x=x;
        center.y=y;
        this.radius=radius;
    }

    /*public function draw():void {
        var gr:Graphics=this.graphics;

        //gr.lineStyle(6, 0x0000FF, .5);
        gr.beginFill(0x0000FF,.5);

        gr.drawCircle(100,100,30);

        gr.endFill();

    }*/

}
}