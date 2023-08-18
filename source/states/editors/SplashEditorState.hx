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
//import flixel.text.FlxTextFormat;
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
//import flixel.group.FlxSpriteGroup;
//import flixel.group.FlxGroup.FlxTypedGroup;

#if MODS_ALLOWED
import sys.FileSystem;
#end

using StringTools;

class SplashEditorState extends MusicBeatState {
    var camGame:FlxCamera;
    var camEditor:FlxCamera;
    var bg:FlxBackdrop;
    var TemplateSplash = {
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
    //var notes:FlxTypedGroup<StrumNote>;
    var splashFile:FlxInputText;
    var xOffset:FlxUINumericStepper;
    var yOffset:FlxUINumericStepper;
    var xScale:FlxUINumericStepper;
    var yScale:FlxUINumericStepper;
    var alpha:FlxUINumericStepper;
    var fps:FlxUINumericStepper;
    var note1Purple:FlxInputText;
    var note1Blue:FlxInputText;
    var note1Green:FlxInputText;
    var note1Red:FlxInputText;
    var note2Purple:FlxInputText;
    var note2Blue:FlxInputText;
    var note2Green:FlxInputText;
    var note2Red:FlxInputText;
    
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

        splashFile = new FlxInputText(10, 100, 100, modding.splashFile);
        splashFile.size = 25;
        splashFile.camera = camEditor;
        add(splashFile);

        xOffset = new FlxUINumericStepper(10, 120, 0.1, modding.xOffset, 0, 999, 1);
        xOffset.camera = camEditor;
        add(xOffset);

        yOffset = new FlxUINumericStepper(10, 140, 0.1, modding.yOffset, 0, 999, 1);
        yOffset.camera = camEditor;
        add(yOffset);

        xScale = new FlxUINumericStepper(10, 160, 0.1, modding.xScale, 0.1, 999, 1);
        xScale.camera = camEditor;
        add(xScale);

        yScale = new FlxUINumericStepper(10, 180, 0.1, modding.yScale, 0.1, 999, 1);
        yScale.camera = camEditor;
        add(yScale);

        alpha = new FlxUINumericStepper(10, 200, 0.6, modding.alpha, 0, 1, 1);
        alpha.camera = camEditor;
        add(alpha);

        fps = new FlxUINumericStepper(10, 220, 1, modding.fps, 1, 999, 1);
        fps.camera = camEditor;
        add(fps);

        note1Purple = new FlxInputText(10, 240, 100, modding.note1Purple);
        note1Purple.size = 25;
        note1Purple.camera = camEditor;
        add(note1Purple);

        note1Blue = new FlxInputText(10, 260, 100, modding.note1Blue);
        note1Blue.size = 25;
        note1Blue.camera = camEditor;
        add(note1Blue);

        note1Green = new FlxInputText(10, 280, 100, modding.note1Green);
        note1Green.size = 25;
        note1Green.camera = camEditor;
        add(note1Green);

        note1Red = new FlxInputText(10, 300, 100, modding.note1Red);
        note1Red.size = 25;
        note1Red.camera = camEditor;
        add(note1Red);

        note2Purple = new FlxInputText(10, 320, 100, modding.note2Purple);
        note2Purple.size = 25;
        note2Purple.camera = camEditor;
        add(note2Purple);

        note2Blue = new FlxInputText(10, 340, 100, modding.note2Blue);
        note2Blue.size = 25;
        note2Blue.camera = camEditor;
        add(note2Blue);

        note2Green = new FlxInputText(10, 360, 100, modding.note2Green);
        note2Green.size = 25;
        note2Green.camera = camEditor;
        add(note2Green);

        note2Red = new FlxInputText(10, 380, 100, modding.note2Red);
        note2Red.size = 25;
        note2Red.camera = camEditor;
        add(note2Red);

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
    function updatePresence() {
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Note Splash Editor", "Editing a cool Note Splash");
		#end
	}
}