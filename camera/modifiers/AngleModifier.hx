package camera.modifiers;

import flixel.FlxCamera;
import flixel.FlxObject;

class AngleModifier extends CameraModifier
{
	override function modifierShit(camGame:FlxCamera, camFollow:FlxObject)
	{
		camGame.angle += curValue;
	}
}
