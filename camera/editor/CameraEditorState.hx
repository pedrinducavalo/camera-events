package camera.editor;

#if LEATHER
import states.MusicBeatState;
#elseif PSYCH
#if (PSYCHVERSION >= "0.7")
import backend.MusicBeatState;
#else
import states.MusicBeatState;
#end
#end
final class CameraEditorState extends MusicBeatState {}
