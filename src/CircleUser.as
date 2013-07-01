package {

public class CircleUser extends Circle {

    protected var deceleration:Number=0.0;
    protected const massIndex:Number=50.0;

    public function CircleUser(x:Number, y:Number, radius:int) {
        super(x,y,radius);
    }

    override public function changeSpeed(deltaSpeedX:Number, deltaSpeedY:Number):void {
        deceleration=0.0;

        var temp_x:Number=Math.sqrt(2/massIndex/radius);//*x/(x*x+y*y);
        var temp_y:Number=Math.sqrt(2/massIndex/radius);//*y/(x*x+y*y);

        if (center.x-deltaSpeedX<0) temp_x*=-1;
        if (center.y-deltaSpeedY<0) temp_y*=-1;

        speed.x=temp_x;
        speed.y=temp_y;
    }
}
}