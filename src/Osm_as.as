

package {


import flash.display.Sprite;
import flash.text.TextField;
[SWF(width="512", height="512", frameRate="24", backgroundColor="#dddddd")]
public class Osm_as extends Sprite {
    public function Osm_as() {


        var textField:TextField = new TextField();
        textField.text = "Hello, World";
        addChild(textField);

        //trace(this.getBounds.height);

        var field:Field=new Field();
        addChild(field);
        field.draw();
    }
}
}
