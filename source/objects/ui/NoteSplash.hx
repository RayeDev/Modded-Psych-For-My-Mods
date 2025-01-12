package objects.ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import openfl.utils.Assets as OpenFlAssets;

typedef SplashData =
{
	splashFile:String,
	xOffset:Float,
	yOffset:Float,
	xScale:Float,
	yScale:Float,
	alpha:Float,
	fps:Int,
	note1Purple:String,
	note1Blue:String,
	note1Green:String,
	note1Red:String,
	note2Purple:String,
	note2Blue:String,
	note2Green:String,
	note2Red:String
}

class NoteSplash extends FlxSprite
{
	public var colorSwap:ColorSwap = null;
	private var idleAnim:String;
	private var textureLoaded:String = null;
	public static var splashJSON:SplashData;
	var isCustom:Bool = false;

	public function new(x:Float = 0, y:Float = 0, ?note:Int = 0) {
		super(x, y);

		#if MODS_ALLOWED
		if (FileSystem.exists(Paths.modsJson('chart/${Paths.formatToSongPath(PlayState.SONG.song)}/customSplash'))) {
		#else
		if (FileSystem.exists(Paths.json('chart/${Paths.formatToSongPath(PlayState.SONG.song)}/customSplash'))) {
		#end
			splashJSON = Json.parse(Paths.getTextFromFile('data/chart/${Paths.formatToSongPath(PlayState.SONG.song)}/customSplash.json'));
			isCustom = true;
		}else{
			splashJSON = Json.parse(Paths.getTextFromFile('data/chart/defaultSplash.json'));
			isCustom = false;
		}
		trace(isCustom);

		var skin:String = '';
		if(splashJSON.splashFile == "" || splashJSON.splashFile == null)
			skin = 'noteSplashes';
		else
			skin = splashJSON.splashFile;

		loadAnims(skin);
		
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		setupNoteSplash(x, y, note);
		antialiasing = ClientPrefs.globalAntialiasing;
	}

	public function setupNoteSplash(x:Float, y:Float, note:Int = 0, texture:String = null, hueColor:Float = 0, satColor:Float = 0, brtColor:Float = 0) {
		setPosition(x - Note.swagWidth * 0.95, y - Note.swagWidth);
		alpha = splashJSON.alpha;

		if(texture == null || splashJSON.splashFile == "" || splashJSON.splashFile == null)
			texture = 'noteSplashes';
		else
			texture = splashJSON.splashFile;

		if(textureLoaded != texture) {
			loadAnims(texture);
		}
		colorSwap.hue = hueColor;
		colorSwap.saturation = satColor;
		colorSwap.brightness = brtColor;
		offset.set(splashJSON.xOffset*ClientPrefs.noteSize/.7, splashJSON.yOffset*ClientPrefs.noteSize/.7);
		scale.set(splashJSON.xScale*ClientPrefs.noteSize/.7, splashJSON.yScale*ClientPrefs.noteSize/.7);

		animation.play('note' + note + '-' + 2, true);
		if(animation.curAnim != null && splashJSON.fps == 24)
			animation.curAnim.frameRate = 24;
		else if(animation.curAnim != null && splashJSON.fps != 24)
			animation.curAnim.frameRate = splashJSON.fps;
	}

	function loadAnims(skin:String) {
		frames = Paths.getSparrowAtlas(skin);
		if(splashJSON.fps == 24){
			animation.addByPrefix("note1-1", splashJSON.note1Blue, 24, false);
			animation.addByPrefix("note2-1", splashJSON.note1Green, 24, false);
			animation.addByPrefix("note0-1", splashJSON.note1Purple, 24, false);
			animation.addByPrefix("note3-1", splashJSON.note1Red, 24, false);
			animation.addByPrefix("note1-2", splashJSON.note2Blue, 24, false);
			animation.addByPrefix("note2-2", splashJSON.note2Green, 24, false);
			animation.addByPrefix("note0-2", splashJSON.note2Purple, 24, false);
			animation.addByPrefix("note3-2", splashJSON.note2Red, 24, false);
		}else{
			animation.addByPrefix("note1-1", splashJSON.note1Blue, splashJSON.fps, false);
			animation.addByPrefix("note2-1", splashJSON.note1Green, splashJSON.fps, false);
			animation.addByPrefix("note0-1", splashJSON.note1Purple, splashJSON.fps, false);
			animation.addByPrefix("note3-1", splashJSON.note1Red, splashJSON.fps, false);
			animation.addByPrefix("note1-2", splashJSON.note2Blue, splashJSON.fps, false);
			animation.addByPrefix("note2-2", splashJSON.note2Green, splashJSON.fps, false);
			animation.addByPrefix("note0-2", splashJSON.note2Purple, splashJSON.fps, false);
			animation.addByPrefix("note3-2", splashJSON.note2Red, splashJSON.fps, false);
		}
	}

	override function update(elapsed:Float) {
		if(animation.curAnim != null)if(animation.curAnim.finished) kill();

		super.update(elapsed);
	}
}