package {

import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.engine.Kerning;
import flash.ui.Keyboard;
import flash.desktop.NativeApplication
import flash.net.FileReference;
//import com.adobe.serialization.json.*

import org.osmf.layout.LayoutTargetSprite;

[SWF(width="512", height="512", frameRate="24", backgroundColor="#dddddd")]

public class Osm_as extends Sprite {
    protected var field:Field;
    protected var fileRef:FileReference;
    public function Osm_as() {
        parserJSON("config.json");



    }

    function parserJSON(fileName:String) {
        fileRef = new FileReference();
        fileRef.addEventListener(Event.SELECT, onFileSelected);
        fileRef.browse();



        var obj:Object=JSON.parse("{\"user\":{\"color\":1}}");
        trace(obj.user.color);
    }

    function startNewGame(evt:KeyboardEvent):void {
        switch (evt.keyCode) {
            case Keyboard.ENTER: field.startNewGame(); break;
            case Keyboard.ESCAPE: NativeApplication.nativeApplication.exit(0); break;
            default: break;
        }


    }



    function onComplete(evt:Event):void {
        var obj:Object=JSON.parse(fileRef.data.toString());
        //trace(fileRef.data.readUTF());
        field = new Field();
        stage.addEventListener(KeyboardEvent.KEY_UP, startNewGame);
        addChild(field);
        field.startNewGame();
    }
    public function onFileSelected(evt:Event):void {
        fileRef.addEventListener(Event.COMPLETE, onComplete);
        fileRef.load();

    }
}
}
