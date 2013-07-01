package {
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;


public class Field extends Sprite {
    protected var circles:Array;
    const windowWidth:int=512;
    const windowHeight:int=512;
    var userColor:uint=0x00ff00;
    var minColor:uint=0xff0000;
    var maxColor:uint=0x0000ff;
    var countOfRivals:int=10;
    var midColor:uint;

    public function Field() {

        var radius:Number=Math.sqrt(windowWidth*windowHeight/countOfRivals/20); //5% пространства занято объектами

        for (var i:int=0; i<countOfRivals; i++) {

            var t:Boolean=true;
            var x,y:Number;
            while (t) {
                t=false;
                x=Math.random()*(windowWidth-2*radius)+radius;
                y=Math.random()*(windowHeight-2*radius)+radius;
                for (var j:int=0; j<numChildren; j++) {
                    var center:Point = Circle(getChildAt(j)).centerOfCircle;
                    if (Math.sqrt((x-center.x)*(x-center.x)
                            +(y-center.y)*(y-center.y))<2*radius+radius/10.0) {
                        t=true;
                        break;
                    }
                }
            }

            // Записать в вектор соперников
            addChild(new Circle(x,y,radius));

            // Установить скорость
            var multX:int=-1;
            var multY:int=-1;
            if (Math.random()>0.5) multX=1;
            if (Math.random()>0.5) multY=1;
            //this->circles.back()->move(10.0*multX,10.0*multY);
        }

        //addChild(new CircleUser(3,4,5));


    }

    public function startNewGame() {
        addChild(new CircleUser(3,4,5));

    }

    public function draw() {
        for (var i:int = 0; i < numChildren; i++) {
            Circle( getChildAt(i)).draw();
        }
    }
}
}