package camera.modifiers;

import flixel.FlxCamera;
import flixel.FlxObject;

class PositionModifier extends CameraModifier
{
	override function setupValues()
	{
		createSubMod('x', 0);
		createSubMod('y', 0);
	}
	
	override function modifierShit(camGame:FlxCamera, camFollow:FlxObject)
	{
		camFollow.x += subValues.get('x').curValue;
		camFollow.y += subValues.get('y').curValue;
	}
}
