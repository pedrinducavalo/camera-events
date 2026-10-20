package camera;

import camera.modifiers.CameraModifierManager;
import camera.events.CameraEventManager;
import camera.data.CameraLoader;

import states.PlayState;

import camera.editor.CameraEditorState;

import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.math.FlxPoint;

final class CameraCore
{
	public var loader:CameraLoader;
	public var modifierManager:CameraModifierManager;
	public var eventManager:CameraEventManager;
	
	public var playStateInstance:PlayState;
	public var editorInstance:CameraEditorState;
	
	public var camGame:FlxCamera; // pra referencia
	public var camFollowPos:FlxPoint;
	
	public function new(instance:Dynamic)
	{
		if (instance is CameraEditorState)
		{
			editorInstance = cast instance;
			/*oldCamGame = editorInstance.gamePreview.camGame;
				oldCamFollow = editorInstance.gamePreview.camFollow; */
		}
		else if (instance is PlayState)
		{
			playStateInstance = cast instance;
			camGame = new FlxCamera();
			camFollowPos = new FlxPoint();
			camFollowPos.set(playStateInstance.camFollow.x, playStateInstance.camFollow.y);
		}
		
		modifierManager = new CameraModifierManager(instance);
		eventManager = new CameraEventManager();
		loader = new CameraLoader(this);
		
		if (loader.data != null && playStateInstance != null)
		{
			playStateInstance.cameraFollowOverride = true;
		}
	}
	
	public function update(elapsed:Float)
	{
		try
		{
			setCamerasToDefault();
			eventManager.update(elapsed);
			setCamerasToMods();
		}
		catch (e)
		{
			trace('Erro ao atualizar o core da câmera: $e');
		}
	}
	
	public function setCamerasToDefault()
	{
		if (playStateInstance != null)
		{
			playStateInstance.camGame.zoom = camGame.zoom;
			playStateInstance.camGame.angle = camGame.angle;
			playStateInstance.camFollow.setPosition(camFollowPos.x, camFollowPos.y);
		}
		else if (editorInstance != null)
		{
			/*
				editorInstance.gamePreview.camGame.zoom = camGame.zoom;
				editorInstance.gamePreview.camGame.angle = camGame.angle;
				editorInstance.gamePreview.camFollow.setPosition(camFollow.x, camFollow.y);
			 */
		}
	}
	
	function setCamerasToMods()
	{
		if (playStateInstance != null)
		{
			modifierManager.applyMods(playStateInstance.camGame, playStateInstance.camFollow);
		}
		else if (editorInstance != null) // quando eu fizer o editor eu descomento isso
		{
			/*
				modifierManager.applyMods(editorInstance.gamePreview.camGame, editorInstance.gamePreview.camFollow);
			 */
		}
	}
}
