package camera.modifiers;

import flixel.FlxCamera;
import flixel.FlxObject;

class ZoomModifier extends CameraModifier
{
	override function setupValues()
	{
		curValue = baseValue = 1;
	}
	
	override function modifierShit(camGame:FlxCamera, camFollow:FlxObject)
	{
		camGame.zoom *= curValue;
	}
}
