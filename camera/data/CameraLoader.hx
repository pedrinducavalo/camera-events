package camera.data;

import openfl.Assets;

import camera.data.file.*;
import camera.util.CameraUtil;

import haxe.Json;

import states.PlayState;

#if (!LEATHER)
import Paths;
#end

import game.Conductor;

using camera.util.CameraUtil;

using StringTools;

final class CameraLoader
{
	public var data(default, null):CameraData;
	
	var core:CameraCore;
	
	public function new(core:CameraCore):Void
	{
		this.core = core;
		data = loadFromJSON(PlayState.SONG.song.toLowerCase(), PlayState.storyDifficultyStr);
		try
		{
			loadModifiers();
			loadEvents();
			trace('Modificadores e eventos carregados com sucesso!');
		}
		catch (e)
		{
			trace('Erro ao carregar os dados da câmera: $e');
		}
	}
	
	public static function loadFromJSON(songFolder:String, difficulty:String):CameraData
	{
		var diff = (difficulty != null) ? difficulty.toLowerCase().trim() : 'hard';
		var path:String;
		
		var diffFileName = 'camera-$diff';
		var defaultFileName = 'camera';
		var diffPath = Paths.getModPath(Paths.json('song data/$songFolder/$diffFileName'));
		var defaultPath = Paths.getModPath(Paths.json('song data/$songFolder/$defaultFileName'));
		
		path = diffPath;
		path ??= defaultPath;
		
		var rawJson:String = '';
		
		if (path != null && Assets.exists(path))
		{
			try
			{
				rawJson = Assets.getText(path).trim();
				trace('Arquivo de camera encontrado em "$path"!');
			}
			catch (e)
			{
				trace('Erro ao tentar encontrar o arquivo da câmera: $e');
			}
		}
		
		if (rawJson != null && rawJson != '' && rawJson.length > 0)
		{
			try
			{
				var parsed:CameraData = Json.parse(rawJson);
				
				parsed.modifiers ??= [];
				parsed.events ??= [];
				
				trace('Arquivo da câmera carregado com sucesso!');
				return parsed;
			}
			catch (e)
			{
				trace('Erro ao tentar conveter o arquivo da câmera: $e');
			}
		}
		
		return CameraUtil.getEmptyJSON();
	}
	
	public function loadModifiers():Void
	{
		if (data == null) return;
		
		try
		{
			core.modifierManager.clear();
			
			for (i in data.modifiers)
			{
				core.initMod(i.name, i.type);
			}
			trace('Modificadores carregados com sucesso!');
		}
		catch (e)
		{
			trace('Erro ao tentar carregar os modificadore: $e');
		}
	}
	
	public function loadEvents():Void
	{
		if (data == null) return;
		
		try
		{
			core.eventManager.clear();
			
			for (i in data.events)
			{
				i.repeatData ??= [{repeat: false, repeatCount: 0, beatGap: 0}];
				
				if (i.repeatData[0].repeat)
				{
					for (c in 0...i.repeatData[0].repeatCount + 1)
					{
						addEvent(i, c * i.repeatData[0].beatGap);
					}
				}
				else
				{
					addEvent(i);
				}
			}
			trace('Eventos carregados com sucesso!');
		}
		catch (e)
		{
			trace('Erro ao tentar carregar os eventos: $e');
		}
	}
	
	function addEvent(event:CameraEventData, beatOffset:Float = 0):Void
	{
		var eventData = event.eventData[0];
		var scheduledBeat = eventData.startBeat + beatOffset;
		var scheduledEvent = event;
		
		core.eventManager.add(scheduledBeat, function(_) applyEvent(scheduledEvent, scheduledBeat), []);
	}
	
	function applyEvent(event:CameraEventData, scheduledBeat:Float):Void
	{
		var eventData = event.eventData[0];
		var subModCheck = eventData.modifier.split(':');
		var beat = Conductor.crochet * .001;
		
		switch (event.type.toLowerCase().trim())
		{
			case "set":
				if (subModCheck.length > 1)
				{
					core.modifierManager.modifiers.get(subModCheck[0]).subValues.get(subModCheck[1]).curValue = eventData.value;
				}
				else
				{
					core.modifierManager.modifiers.get(eventData.modifier).curValue = eventData.value;
				}
			case "tween":
				if (subModCheck.length > 1)
				{
					core.modifierManager.tweenSubModifier(subModCheck[0], subModCheck[1], eventData.value, eventData.duration * beat, eventData.ease, scheduledBeat);
				}
				else core.modifierManager.tweenModifier(eventData.modifier, eventData.value, eventData.duration * beat, eventData.ease, scheduledBeat);
			case "settween":
				if (subModCheck.length > 1)
				{
					core.modifierManager.modifiers.get(subModCheck[0]).subValues.get(subModCheck[1]).curValue = eventData.value;
					core.modifierManager.tweenSubModifier(subModCheck[0], subModCheck[1], eventData.finalValue, eventData.duration * beat, eventData.ease, scheduledBeat);
				}
				else
				{
					core.modifierManager.modifiers.get(eventData.modifier).curValue = eventData.value;
					core.modifierManager.tweenModifier(eventData.modifier, eventData.finalValue, eventData.duration * beat, eventData.ease, scheduledBeat);
				}
		}
	}
}
