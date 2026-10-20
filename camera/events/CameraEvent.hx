package camera.events;

class CameraEvent
{
	public var time:Float;
	public var func:Array<String>->Void;
	public var args:Array<String>;
	
	public function new(time:Float, func:Array<String>->Void, args:Array<String>):Void
	{
		this.time = time;
		this.func = func;
		this.args = args;
	}
}
