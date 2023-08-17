package states.editors;

import flixel.addons.ui.FlxUIDropDownMenu;
import animateatlas.AtlasFrameMaker;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import openfl.net.FileReference;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import haxe.Json;
import flixel.system.debug.interaction.tools.Pointer.GraphicCursorCross;
import lime.system.Clipboard;
import flixel.animation.FlxAnimation;
import flixel.addons.display.FlxBackdrop;
import objects.ui.StrumNote;

#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class SplashEditorState extends MusicBeatState {
    var camGame:FlxCamera;
    var camEditor:FlxCamera;
    var bg:FlxBackdrop;
    var TemplateSplash:String =
    '{
        "splashFile": "noteSplashes",
        "xOffset": 20,
        "yOffset": -10,
        "xScale": 1,
        "yScale": 1,
        "alpha": 0.6,
        "fps": 24,
        "note1Purple": "note splash diamond purple 1",
        "note1Blue": "note splash diamond blue 1",
        "note1Green": "note splash diamond green 1",
        "note1Red": "note splash diamond red 1",
        "note2Purple": "note splash diamond purple 2",
        "note2Blue": "note splash diamond blue 2",
        "note2Green": "note splash diamond green 2",
        "note2Red": "note splash diamond red 2"
    }';
    var modding = {
        splashFile: "noteSplashes",
        xOffset: 20,
        yOffset: -10,
        xScale: 1,
        yScale: 1,
        alpha: 0.6,
        fps: 24,
        note1Purple: "note splash diamond purple 1",
        note1Blue: "note splash diamond blue 1",
        note1Green: "note splash diamond green 1",
        note1Red: "note splash diamond red 1",
        note2Purple: "note splash diamond purple 2",
        note2Blue: "note splash diamond blue 2",
        note2Green: "note splash diamond green 2",
        note2Red: "note splash diamond red 2"
    };

    override function create(){
        FlxG.mouse.visible = true;
    
        camGame = new FlxCamera();
		camEditor = new FlxCamera();
		camEditor.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camEditor);
		FlxCamera.defaultCameras = [camGame];

        bg = new FlxBackdrop(Paths.image('menuDesat'), XY, 0, 0);
        bg.scrollFactor.set(1, 1);
        bg.velocity.set(10, 10);
        bg.alpha = 0.3;
        add(bg);

        for(i in 0...4)
            var st:StrumNote = new StrumNote(0, FlxG.height - 150, i, 0);

        super.create();
    }
    override function update(elapsed:Float){
        if (FlxG.keys.justPressed.ESCAPE) {
            MusicBeatState.switchState(new MasterEditorMenu());
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
            FlxG.mouse.visible = false;
            return;
        }
        super.update(elapsed);
    }
}