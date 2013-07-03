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

[SWF(width="1024", height="1024", frameRate="24", backgroundColor="#dddddd")]

public class Osm_as extends Sprite {
    protected var field:Field;
    protected var fileRef:FileReference;
    public function Osm_as() {
        // Показать окно выбора пути файла конфигурации
        fileRef = new FileReference();
        fileRef.addEventListener(Event.SELECT, onFileSelected);
        fileRef.browse();
    }

    public function onFileSelected(evt:Event):void {
        // Загрузка файла
        fileRef.addEventListener(Event.COMPLETE, onComplete);
        fileRef.load();
    }

    function onComplete(evt:Event):void {
        // Парсинг файла
        var file:Object=JSON.parse(fileRef.data.toString());

        // Инициализация игрового поля
        field = new Field(1024,1024,file.user.color,file.enemy.color1,file.enemy.color2,file.enemy.count);
        stage.addEventListener(KeyboardEvent.KEY_UP, startNewGame);
        addChild(field);
        //field.startNewGame();
    }

    function startNewGame(evt:KeyboardEvent):void {
        switch (evt.keyCode) {
            case Keyboard.ENTER: field.startNewGame(); break;
            case Keyboard.ESCAPE: NativeApplication.nativeApplication.exit(0); break;
            default: break;
        }
    }

}
}
