package {
import flash.display.Graphics;
import flash.display.Sprite;
import flash.geom.Point;

public class Circle extends Sprite {

    const windowWidth:int = 512;
    const windowHeight:int = 512;
    protected var center:Point;
    protected var radius:int;
    protected var color:uint;
    protected var speed:Point;

    public function Circle(x:Number, y:Number, radius:int) {
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

        //gr.lineStyle(6, 0x0000FF, .5);
        gr.beginFill(0x0000FF, .5);

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

    public function capture(circle:Circle) {
        var intersectionValue:Number = radius + circle.radius - getDistance(circle);
        if (intersectionValue > 0.0) {
            if (radius >= circle.radius)
                increaseSquare(circle.getTheDifferenceSquares(intersectionValue));
            else
                circle.increaseSquare(getTheDifferenceSquares(intersectionValue));
            if (radius <= 1.0) return 1;
            if (circle.radius <= 1.0) return 2;
        }
        return 0;
    }

    // Увеличить площадь объекта на deltaSquare
    public function increaseSquare(deltaSquare:Number):void {
        radius = Math.sqrt((square + deltaSquare) / Math.PI);
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

    public function get square():Number {
        return radius * radius * Math.PI;
    }

    public function get centerOfCircle():Point {
        return center;
    }


}
}