package camera.modifiers;

import camera.util.CameraUtil;

import game.Conductor;

import flixel.tweens.FlxTween;

import camera.editor.CameraEditorState;

import modcharting.ModchartUtil;

import states.PlayState;

import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.math.FlxMath;

class CameraModifierManager
{
	public var modifiers:Map<String, CameraModifier> = new Map<String, CameraModifier>();
	public var playStateInstance:PlayState;
	public var editorInstance:CameraEditorState;
	
	public function new(instance:Dynamic)
	{
		if (instance is PlayState) playStateInstance = cast instance;
		else if (instance is CameraEditorState) editorInstance = cast instance;
		initStartMods();
	}
	
	public function add(mod:CameraModifier)
	{
		remove(mod.ID);
		modifiers.set(mod.ID, mod);
	}
	
	public function remove(key:String)
	{
		modifiers.remove(key);
	}
	
	public function clear()
	{
		modifiers.clear();
		initStartMods();
	}
	
	public function applyMods(camGame:FlxCamera, camFollow:FlxObject)
	{
		for (i in modifiers)
		{
			i.modifierShit(camGame, camFollow);
		}
	}
	
	function initStartMods()
	{
		add(new ZoomModifier('zoom', (playStateInstance != null) ? playStateInstance : editorInstance));
		add(new PositionModifier('pos', (playStateInstance != null) ? playStateInstance : editorInstance));
		add(new AngleModifier('angle', (playStateInstance != null) ? playStateInstance : editorInstance));
	}
	
	public function tweenModifier(mod:String, val:Float, time:Float, easing:String, beat:Float)
	{
		if (modifiers.exists(mod))
		{
			if (Conductor.songPosition >= ModchartUtil.getTimeFromBeat(beat) + (time * 1000))
			{
				modifiers.get(mod).curValue = val;
				return;
			}
			
			var tween = FlxTween.tween(modifiers.get(mod), {curValue: val}, time, {ease: CameraUtil.easeFromString(easing)});
			if (Conductor.songPosition > ModchartUtil.getTimeFromBeat(beat))
			{
				@:privateAccess
				tween._secondsSinceStart += (Conductor.songPosition - ModchartUtil.getTimeFromBeat(beat)) * .001;
				@:privateAccess
				tween.update(0);
			}
		}
	}
	
	public function tweenSubModifier(mod:String, subMod:String, val:Float, time:Float, easing:String, beat:Float)
	{
		if (modifiers.exists(mod))
		{
			var easefunc = CameraUtil.easeFromString(easing);
			var startValue = modifiers.get(mod).subValues.get(subMod).curValue;
			
			if (Conductor.songPosition >= ModchartUtil.getTimeFromBeat(beat) + (time * 1000))
			{
				modifiers.get(mod).subValues.get(subMod).curValue = val;
				return;
			}
			
			var tween = FlxTween.num(startValue, val, time,
				{
					ease: easefunc,
					onUpdate: function(tween:FlxTween) {
						if (modifiers.exists(mod)) modifiers.get(mod).subValues.get(subMod).curValue = FlxMath.lerp(startValue, val, easefunc(tween.percent));
					}
				});
			if (Conductor.songPosition > ModchartUtil.getTimeFromBeat(beat))
			{
				@:privateAccess
				tween._secondsSinceStart += (Conductor.songPosition - ModchartUtil.getTimeFromBeat(beat)) * .001;
				@:privateAccess
				tween.update(0);
			}
		}
	}
}
