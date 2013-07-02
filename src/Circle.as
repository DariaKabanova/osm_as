package {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.geom.Point;

public class Circle extends Sprite {

    const windowWidth:int = 1024;
    const windowHeight:int = 1024;
    protected var center:Point;
    protected var radius:Number;
    protected var color:uint;
    protected var speed:Point;

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
        if (x - radius < 0.0) {
            center.x = -x + 2 * radius;
            speed.x *= -1;
        }
        else if (x + radius > windowWidth) {
            center.x = 2 * windowWidth - x - 2 * radius;
            speed.x *= -1;
        }
        else center.x = x;
        if (y - radius < 0.0) {
            center.y = -y + 2 * radius;
            speed.y *= -1;
        }
        else if (y + radius > windowHeight) {
            center.y = 2 * windowHeight - y - 2 * radius;
            speed.y *= -1;
        }
        else center.y = y;
    }

    public function capture(circle:Circle):int { ////????????
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
            trace(deltaSquare);
            radius = Math.sqrt((square + deltaSquare) / Math.PI);

        }
    }

    // Изменить направление скорости, если радиус circle больше, чем у this
    public function changeDirection(circle:Circle):void {
        if (circle.getRadius>radius) { // Убегает, если больше
            if ((x-circle.centerOfCircle.x<0 && speed.x>0) || (x-circle.centerOfCircle.x>0 && speed.x<0)) speed.x*=-1;
            if ((y-circle.centerOfCircle.y<0 && speed.y>0) || (y-circle.centerOfCircle.y>0 && speed.y<0)) speed.y*=-1;
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



}
}