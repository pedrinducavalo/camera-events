package camera.modifiers;

import camera.editor.CameraEditorState;

import states.PlayState;

import flixel.FlxCamera;
import flixel.FlxObject;

class CameraModifier
{
	public var baseValue:Float = 0;
	public var curValue:Float = 0;
	public var subValues:Map<String, SubCameraModifier> = new Map<String, SubCameraModifier>();
	public var ID:String = '';
	public var playStateInstance:PlayState;
	public var editorInstance:CameraEditorState;
	
	public function new(name:String = '', ?instance:Dynamic)
	{
		ID = name;
		if (instance is PlayState) playStateInstance = cast instance;
		else if (instance is CameraEditorState) editorInstance = cast instance;
		setupValues();
	}
	
	public dynamic function modifierShit(camGame:FlxCamera, camFollow:FlxObject) {}
	
	public dynamic function setupValues() {}
	
	public function reset()
	{
		curValue = baseValue;
		for (i in subValues)
			i.curValue = i.baseValue;
	}
	
	public function duplicate():CameraModifier
	{
		var mod = new CameraModifier(ID, (playStateInstance != null) ? playStateInstance : editorInstance);
		mod.baseValue = baseValue;
		mod.curValue = curValue;
		mod.subValues = subValues;
		return mod;
	}
	
	public function createSubMod(name:String, startValue:Float) subValues.set(name, new SubCameraModifier(startValue));
}

class SubCameraModifier
{
	public var baseValue:Float;
	public var curValue:Float;
	
	public function new(value:Float = 0)
	{
		baseValue = value;
		curValue = value;
	}
}
