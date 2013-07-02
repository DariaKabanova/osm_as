package {

import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.engine.Kerning;
import flash.ui.Keyboard;
import flash.desktop.NativeApplication

import org.osmf.layout.LayoutTargetSprite;

[SWF(width="512", height="512", frameRate="24", backgroundColor="#dddddd")]

public class Osm_as extends Sprite {
    protected var field:Field;
    public function Osm_as() {

        //var roundw:Rectangle=new Rectangle(0,0,512,512);


        //trace(this.getBounds.height);


        field = new Field();
        stage.addEventListener(MouseEvent.CLICK, onStartDrag);
        stage.addEventListener(KeyboardEvent.KEY_UP, startNewGame);
        addChild(field);

        field.startNewGame();

    }
    function onStartDrag(evt:MouseEvent):void {
        field.startNewGame();
        trace("ff");
    }

    function startNewGame(evt:KeyboardEvent):void {
        switch (evt.keyCode) {
            case Keyboard.ENTER: field.startNewGame(); break;
            case Keyboard.ESCAPE:  NativeApplication.nativeApplication.exit(0); break;
            default: break;
        }

    }
}
}
