package camera;

import camera.modifiers.CameraModifierManager;
import camera.events.CameraEventManager;
import camera.data.CameraLoader;

import states.PlayState;

import camera.editor.CameraEditorState;

import flixel.FlxObject;
import flixel.FlxCamera;

final class CameraCore
{
	public var loader:CameraLoader;
	public var modifierManager:CameraModifierManager;
	public var eventManager:CameraEventManager;
	
	public var playStateInstance:PlayState;
	public var editorInstance:CameraEditorState;
	
	public var oldCamGame:FlxCamera;
	public var oldCamFollow:FlxObject;
	
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
			oldCamGame = playStateInstance.camGame;
			oldCamFollow = playStateInstance.camFollow;
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
			playStateInstance.camGame = oldCamGame;
			playStateInstance.camFollow = oldCamFollow;
		}
		else if (editorInstance != null)
		{
			/*
				editorInstance.gamePreview.camGame = oldCamGame;
				editorInstance.gamePreview.camFollow = oldCamFollow;
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
