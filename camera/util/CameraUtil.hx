package camera.util;

import flixel.tweens.FlxEase;

import camera.data.CameraLoader;
import camera.data.file.CameraData;
import camera.modifiers.CameraModifier;

using StringTools;

@:nullSafety
final class CameraUtil
{
	private function new() {}
	
	public static function getEmptyJSON():CameraData
	{
		return {
			modifiers: [],
			events: []
		}
	}
	
	public static function initMod(_core:CameraCore, name:String, modClass:String, inEditor:Bool = false):CameraCore
	{
		var mod = Type.resolveClass('camera.modifiers.' + modClass);
		mod ??= Type.resolveClass('camera.modifiers.' + modClass + "Modifier");
		
		if (mod != null)
		{
			var modifier:CameraModifier = cast Type.createInstance(mod, [name, (_core.playStateInstance != null) ? _core.playStateInstance : _core.editorInstance]);
			_core.modifierManager.add(modifier);
		}
		
		return _core;
	}
	
	public static function easeFromString(ease:String, ?type:String):EaseFunction
	{
		var easing = (type != null) ? ease.toLowerCase().trim() + type.toLowerCase().trim() : ease.toLowerCase().trim();
		switch (easing)
		{
			case 'backin':
				return FlxEase.backIn;
			case 'backinout':
				return FlxEase.backInOut;
			case 'backout':
				return FlxEase.backOut;
			case 'bouncein':
				return FlxEase.bounceIn;
			case 'bounceinout':
				return FlxEase.bounceInOut;
			case 'bounceout':
				return FlxEase.bounceOut;
			case 'circin':
				return FlxEase.circIn;
			case 'circinout':
				return FlxEase.circInOut;
			case 'circout':
				return FlxEase.circOut;
			case 'cubein':
				return FlxEase.cubeIn;
			case 'cubeinout':
				return FlxEase.cubeInOut;
			case 'cubeout':
				return FlxEase.cubeOut;
			case 'elasticin':
				return FlxEase.elasticIn;
			case 'elasticinout':
				return FlxEase.elasticInOut;
			case 'elasticout':
				return FlxEase.elasticOut;
			case 'expoin':
				return FlxEase.expoIn;
			case 'expoinout':
				return FlxEase.expoInOut;
			case 'expoout':
				return FlxEase.expoOut;
			case 'quadin':
				return FlxEase.quadIn;
			case 'quadinout':
				return FlxEase.quadInOut;
			case 'quadout':
				return FlxEase.quadOut;
			case 'quartin':
				return FlxEase.quartIn;
			case 'quartinout':
				return FlxEase.quartInOut;
			case 'quartout':
				return FlxEase.quartOut;
			case 'quintin':
				return FlxEase.quintIn;
			case 'quintinout':
				return FlxEase.quintInOut;
			case 'quintout':
				return FlxEase.quintOut;
			case 'sinein':
				return FlxEase.sineIn;
			case 'sineinout':
				return FlxEase.sineInOut;
			case 'sineout':
				return FlxEase.sineOut;
			case 'smoothstepin':
				return FlxEase.smoothStepIn;
			case 'smoothstepinout':
				return FlxEase.smoothStepInOut;
			case 'smoothstepout':
				return FlxEase.smoothStepOut;
			case 'smootherstepin':
				return FlxEase.smootherStepIn;
			case 'smootherstepinout':
				return FlxEase.smootherStepInOut;
			case 'smootherstepout':
				return FlxEase.smootherStepOut;
		}
		
		return FlxEase.linear;
	}
}
