package {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Point;

public class Circle extends Sprite {

    const windowWidth:int = 1536;
    const windowHeight:int = 1024;
    protected var center:Point;
    protected var radius:Number;
    protected var color:uint;
    protected var speed:Point;
    protected var block_i:int;
    protected var block_j:int;

    public function Circle(x:Number, y:Number, radius:Number) {
        center = new Point(x, y);
        speed = new Point(0.0, 0.0);
        this.radius = radius;
    }

    public function changeSpeed(deltaSpeedX:Number, deltaSpeedY:Number):void {
    }

    public function motion():void {
    }

    public function draw():void {
        var gr:Graphics = this.graphics;
        gr.clear();
        gr.beginFill(color, 1.0);
        gr.drawCircle(center.x, center.y, radius);
        gr.endFill();

    }

    public function hitTheWall(x:Number, y:Number) {
        var newCenter:Point=new Point();
        if (x - radius < 0.0) {
            newCenter.x = -x + 2 * radius;
            speed.x *= -1;
        }
        else if (x + radius > windowWidth) {
            newCenter.x = 2 * windowWidth - x - 2 * radius;
            speed.x *= -1;
        }
        else newCenter.x = x;
        if (y - radius < 0.0) {
            newCenter.y = -y + 2 * radius;
            speed.y *= -1;
        }
        else if (y + radius > windowHeight) {
            newCenter.y = 2 * windowHeight - y - 2 * radius;
            speed.y *= -1;
        }
        else newCenter.y = y;

        /*
        // Смещение центра
        var dx:Number, dy:Number;
        dx=newCenter.x-center.x;
        dy=newCenter.y-center.y;



        // Коэффициент определения точки соприкосновения
        //var k:Point=new Point(speed.x/(speed.x+speed.y),speed.y/(speed.x+speed.y));
        var angle:Number=Math.atan(dy/dx);

        // Точка соприкосновения
        var point:Point=new Point(newCenter.x+radius*Math.cos(angle),newCenter.y+radius*Math.sin(angle));

        var gr:Graphics = this.graphics;
        gr.clear();



        //trace(parent.hitTestPoint(point.x,point.y,true));
        if (parent.hitTestPoint(point.x,point.y,true)) {
            center=newCenter;
            //trace(parent.);
            //trace("-");
            var circles:Array=parent.getObjectsUnderPoint(point);
            for (var i:int=0; i<circles.length; i++)
                capture(circles[i]);
            //trace("-");
        }

        //parent.areInaccessibleObjectsUnderPoint() */

        center=newCenter;


    }

    public function capture(circle:Circle):int {
        var intersectionValue:Number = radius + circle.radius - getDistance(circle);
        if (intersectionValue > 0.0) {
            if (radius >= circle.getRadius)

                increaseSquare(circle.getTheDifferenceSquares(intersectionValue));
            else
                circle.increaseSquare(getTheDifferenceSquares(intersectionValue));
            if (radius <= 0.0) return 1;
            if (circle.getRadius <= 0.0) return 2;
        }
        return 0;
    }

    // Увеличить площадь объекта на deltaSquare
    public function increaseSquare(deltaSquare:Number):void {
        if (deltaSquare>0) {
            radius = Math.sqrt((square + deltaSquare) / Math.PI);

        }
    }

    // Изменить направление скорости, если радиус circle больше, чем у this
    public function changeDirection(circle:Circle):void {
        if (circle.getRadius>radius) { // Убегает, если больше
            if ((center.x-circle.centerOfCircle.x<0 && speed.x>0) || (center.x-circle.centerOfCircle.x>0 && speed.x<0)) speed.x*=-1;
            if ((center.y-circle.centerOfCircle.y<0 && speed.y>0) || (center.y-circle.centerOfCircle.y>0 && speed.y<0)) speed.y*=-1;
        }
    }

    // Получить разницу площадей при уменьшении диаметра
    public function getTheDifferenceSquares(deltaRadius:Number):Number {
        var lastSquare:Number = square;
        radius -= deltaRadius;
        return lastSquare - square;
    }

    public function getDistance(circle:Circle) {
        return Point.distance(center, circle.center);
    }

    // Установить цвет, который зависит от размера объекта
    public function setColor(minRadius:Number, maxRadius:Number, minColor:uint, maxColor:uint):void {
        var valueOfNormalized:Number=(radius-minRadius)/(maxRadius-minRadius);
        var colorTransform:ColorTransform=new ColorTransform();
        var maxColorTransform:ColorTransform=new ColorTransform();
        maxColorTransform.color=maxColor;
        var minColorTransform:ColorTransform=new ColorTransform();
        minColorTransform.color=minColor;
        colorTransform.blueOffset=valueOfNormalized*(maxColorTransform.blueOffset-minColorTransform.blueOffset)+
                minColorTransform.blueOffset;
        colorTransform.greenOffset=valueOfNormalized*(maxColorTransform.greenOffset-minColorTransform.greenOffset)+
                minColorTransform.greenOffset;
        colorTransform.redOffset=valueOfNormalized*(maxColorTransform.redOffset-minColorTransform.redOffset)+
                minColorTransform.redOffset;
        color=colorTransform.color;
    }

    public function set newColor(value:uint):void {
        color=value;
    }

    public function get getRadius():Number {
        return radius;
    }

    public function get square():Number {
        return radius * radius * Math.PI;
    }

    public function get centerOfCircle():Point {
        return center;
    }

    public function set newRadius(value:Number):void {
        radius=value;
    }

    public function get block_x():int {
        return block_i;
    }

    public function get block_y():int {
        return block_j;
    }

    public function set block_x(value:int):void {
        block_i=value;
    }

    public function set block_y(value:int):void {
        block_j=value;
    }

    public function setBlock(x:int, y:int):void {
        block_i=x;
        block_j=y;
    }



}
}