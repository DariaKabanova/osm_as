package {
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.MovieClip;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.utils.Timer;


public class Field extends Sprite {
    protected var circles:Array;
    var windowWidth:int;
    var windowHeight:int;
    var userColor:uint;
    var minColor:uint;
    var maxColor:uint;
    var countOfEnemies:int;
    var midColor:uint;
    var halfOfTotalSquare:Number;
    var result:int;
    var timer:Timer;
    var fps:int;
    var drawingFlag:Boolean;



    public function Field(windowWidth:int, windowHeight:int, userColor:Array, minColor:Array, maxColor:Array, countOfEnemies) {
        this.windowWidth=windowWidth;
        this.windowHeight=windowHeight;
        this.userColor=calculatingColor(userColor);
        this.minColor=calculatingColor(minColor);
        this.maxColor=calculatingColor(maxColor);
        this.countOfEnemies=countOfEnemies;

        var gr:Graphics = this.graphics;
        gr.clear();
        gr.beginFill(0x000000, .1);
        gr.drawRect(0, 0, windowWidth, windowHeight);
        gr.endFill();

        // Нахождение среднего цвета
        var midColorTransform:ColorTransform=new ColorTransform();
        var maxColorTransform:ColorTransform=new ColorTransform();
        maxColorTransform.color=this.maxColor;
        var minColorTransform:ColorTransform=new ColorTransform();
        minColorTransform.color=this.minColor;
        midColorTransform.blueOffset=0.5*(maxColorTransform.blueOffset+minColorTransform.blueOffset);
        midColorTransform.greenOffset=0.5*(maxColorTransform.greenOffset+minColorTransform.greenOffset);
        midColorTransform.redOffset=0.5*(maxColorTransform.redOffset+minColorTransform.redOffset);
        midColor=midColorTransform.color;

        startNewGame();

        addEventListener(MouseEvent.MOUSE_DOWN, mouseDownClick);

        timer = new Timer(1000);// FPS
        timer.addEventListener(TimerEvent.TIMER, onTimer);
        timer.start();

        drawingFlag=false;

        addEventListener(Event.ENTER_FRAME, onEnterFrame);



    }

    public function startNewGame():void {


        for (var i:int=numChildren-1; i>=0; i--)
            removeChildAt(i);
        result=0;
        var radius:Number = Math.sqrt(windowWidth * windowHeight / countOfEnemies / 20); //5% пространства занято объектами

        addChild(new CircleUser(windowWidth / 2.0, windowHeight / 2.0, radius));
        Circle(getChildAt(0)).newColor=userColor;
        halfOfTotalSquare=countOfEnemies*Circle(getChildAt(0)).square/2;

        for (var i:int = 0; i < countOfEnemies; i++) {

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
            if (Math.random() >= 0.5) multX = 1;
            if (Math.random() >= 0.5) multY = 1;
            Circle(getChildAt(numChildren - 1)).changeSpeed(10.0 * multX, 10.0 * multY);
        }
        //stage.addEventListener(Event.ENTER_FRAME,onFrameLoop);
    }

    public function draw():void {
        for (var i:int = 0; i < numChildren; i++) {
            Circle(getChildAt(i)).draw();
        }
    }

    public function move():int {
        for (var i:int = 0; i < numChildren; i++) {
            Circle(getChildAt(i)).motion();

            for (var j:int=i+1; j<numChildren; j++) {
                // изменить направление скорости
                Circle(getChildAt(j)).changeDirection(Circle(getChildAt(i)));

                var flag:int=Circle(getChildAt(i)).capture(Circle(getChildAt(j)));
                if (flag==2) {// был поглощен j-ый
                    removeChildAt(j);
                    j--;
                }
                if (flag==1) {// был поглощен i-ый
                    removeChildAt(i);
                    if (i==0) return 2;// Проигрыш
                    break;
                }
            }

        }

        // Проверка на победу
        if (Circle(getChildAt(0)).square>halfOfTotalSquare) return 1;// Победа

        // Проверка на проражение
        var check:Boolean=true;
        for (var i:int=1; i<numChildren; i++) {
            if (Circle(getChildAt(i)).square>halfOfTotalSquare) return 2;// Поражение (есть объект, у которого площадь больше половины всей площади// )
            if (Circle(getChildAt(i)).square<=Circle(getChildAt(0)).square) {
                check=false;
                break;
            }
        }
        if (check) return 2;// Поражение (у объекта игрока наименьшая площадь)

        // Замена цвета в зависимости от радиуса
        var minRadius:Number=Circle(getChildAt(0)).getRadius, maxRadius:Number=minRadius;
        for (var i:int = 1; i <numChildren; i++) {
            //найти максимальный и минимальный радиусы
            if (Circle(getChildAt(i)).getRadius < minRadius) minRadius=Circle(getChildAt(i)).getRadius;
            if (Circle(getChildAt(i)).getRadius > maxRadius) maxRadius=Circle(getChildAt(i)).getRadius;
        }

        // Радиус пользовательского объекта
        var userRadius:Number=Circle(getChildAt(0)).getRadius;
        for (var i:int=1; i<numChildren; i++) {
            if (Circle(getChildAt(i)).getRadius==userRadius)
                Circle(getChildAt(i)).newColor=midColor;
            else {
                if (Circle(getChildAt(i)).getRadius<=userRadius)
                    Circle(getChildAt(i)).setColor(minRadius, userRadius, minColor, midColor);
                else Circle(getChildAt(i)).setColor(userRadius, maxRadius, midColor, maxColor);
            }
        }



        return 0;
    }

    function onTimer(evt:TimerEvent):void {
        trace(fps);
        if (fps==24) drawingFlag=true;
        fps=0;

    }

    function mouseDownClick(evt:MouseEvent):void {
        Circle(getChildAt(0)).changeSpeed(evt.stageX,evt.stageY);
        trace("1");
    }

    function calculatingColor(colorArray:Array):uint {
        var colorTransform:ColorTransform=new ColorTransform();
        colorTransform.redOffset=colorArray[0]*255;
        colorTransform.greenOffset=colorArray[1]*255;
        colorTransform.blueOffset=colorArray[2]*255;
        return colorTransform.color;
    }

    private function onEnterFrame(e:Event):void
    {
        fps++;

        if (result==0 && fps<=24) {

            result=move();
            if (result==1) {
                var textField:TextField=new TextField();
                textField.text="Победа";
                textField.textColor=0x000000;
                addChild(textField);
            }
            if (result==2) {
                var textField:TextField=new TextField();
                textField.text="Проигрыш";
                textField.textColor=0x00ff00;
                //textField.length=100;
                addChild(textField);
            }
            draw();

        }

    }





}
}