package camera.data.file;

typedef CameraEventData =
{
	var type:String; // set ou tween
	@:optional var posInEditor:Null<Int>;
	var eventData:Array<
		{
			var modifier:String;
			var startBeat:Float;
			var value:Float;
			@:optional var finalValue:Null<Float>; // pra settweens
			@:optional var duration:Null<Float>; // em beats
			@:optional var ease:Null<String>; // pra tweens
		}>;
	@:optional var repeatData:Null<Array<
		{
			var repeat:Null<Bool>;
			var repeatCount:Null<Int>;
			var beatGap:Null<Float>;
		}>>;
}
