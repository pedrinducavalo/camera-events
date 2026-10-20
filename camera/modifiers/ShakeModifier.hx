package camera.modifiers;

import flixel.FlxCamera;
import flixel.FlxObject;

import game.Conductor;

class ShakeModifier extends CameraModifier
{
	var shake:Float = 0;
	
	override function modifierShit(camGame:FlxCamera, camFollow:FlxObject)
	{
		shake = Math.sin(Conductor.songPosition * .01) * curValue * 10;
		
		camGame.x += shake;
		camGame.y += shake;
	}
}
