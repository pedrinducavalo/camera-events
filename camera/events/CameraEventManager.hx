package camera.events;

import game.Conductor;

import modcharting.ModchartUtil;

import camera.data.file.*;

class CameraEventManager
{
	public var events:Array<CameraEvent> = [];
	
	var eventIndex:Int = 0;
	
	public function new():Void {}
	
	public function update(elapsed:Float):Void
	{
		var safety:Int = 0;
		while (eventIndex < events.length && safety < 1000)
		{
			var event:CameraEvent = events[eventIndex];
			if (Conductor.songPosition < event.time)
			{
				break;
			}
			event.func(event.args);
			eventIndex++;
			safety++;
		}
		if (eventIndex > 256)
		{
			events = events.slice(eventIndex);
			eventIndex = 0;
		}
	}
	
	public inline function add(beat:Float, func:Array<String>->Void, args:Array<String>):Void
	{
		var event = new CameraEvent(ModchartUtil.getTimeFromBeat(beat), func, args);
		var inserted = false;
		for (i in eventIndex...events.length)
		{
			if (event.time < events[i].time)
			{
				events.insert(i, event);
				inserted = true;
				break;
			}
		}
		if (!inserted)
		{
			events.push(event);
		}
	}
	
	public inline function clear():Void
	{
		events = [];
		eventIndex = 0;
	}
}
