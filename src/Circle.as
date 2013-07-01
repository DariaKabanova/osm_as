package {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;

public class Circle extends Sprite{

    protected var center:Point;
    protected var radius:int;
    protected var color:uint;
    protected var speed:Point;

    public function Circle(x:Number, y:Number, radius:int) {
        center=new Point(x,y);
        speed=new Point(0.0,0.0);
        this.radius=radius;
    }

    public function changeSpeed(deltaSpeedX:Number, deltaSpeedY:Number):void {}

    public function draw():void {
        var gr:Graphics=this.graphics;



        //gr.lineStyle(6, 0x0000FF, .5);
        gr.beginFill(0x0000FF,.5);

        gr.drawCircle(center.x,center.y,radius);

        gr.endFill();

    }

    public function get centerOfCircle():Point {
        return center;
    }


}
}