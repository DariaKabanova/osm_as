package {
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;


public class Field extends Sprite {
    protected var circles:Array;
    const windowWidth:int = 512;
    const windowHeight:int = 512;
    var userColor:uint = 0x00ff00;
    var minColor:uint = 0xff0000;
    var maxColor:uint = 0x0000ff;
    var countOfRivals:int = 10;
    var midColor:uint;

    public function Field() {

        var timer:Timer = new Timer(42);
        timer.addEventListener(TimerEvent.TIMER, onTimer);
        timer.start();

    }

    public function startNewGame():void {
        var radius:Number = Math.sqrt(windowWidth * windowHeight / countOfRivals / 20); //5% пространства занято объектами
        addChild(new CircleUser(windowWidth / 2.0, windowHeight / 2.0, radius));

        for (var i:int = 0; i < countOfRivals; i++) {

            var t:Boolean = true;
            var x:Number, y:Number;
            while (t) {
                t = false;
                x = Math.random() * (windowWidth - 2 * radius) + radius;
                y = Math.random() * (windowHeight - 2 * radius) + radius;
                for (var j:int = 0; j < numChildren; j++) {
                    var center:Point = Circle(getChildAt(j)).centerOfCircle;
                    if (Math.sqrt((x - center.x) * (x - center.x)
                            + (y - center.y) * (y - center.y)) < 2 * radius + radius / 10.0) {
                        t = true;
                        break;
                    }
                }
            }

            // Записать соперников в список отображения
            addChild(new CircleEnemy(x, y, radius));

            // Установить скорость
            var multX:int = -1;
            var multY:int = -1;
            if (Math.random() > 0.5) multX = 1;
            if (Math.random() > 0.5) multY = 1;
            Circle(getChildAt(numChildren - 1)).changeSpeed(10.0 * multX, 10.0 * multY);
        }
        //stage.addEventListener(Event.ENTER_FRAME,onFrameLoop);
    }

    public function draw() {
        for (var i:int = 0; i < numChildren; i++) {
            Circle(getChildAt(i)).draw();
        }
    }

    public function move() {
        for (var i:int = 1; i < numChildren; i++) {
            Circle(getChildAt(i)).motion();
        }
    }

    function onFrameLoop(evt:Event):void {

    }

    function onTimer(evt:TimerEvent):void {
        move();
        draw();
    }
}
}