# Camera Events

A lightweight Haxe library for Friday Night Funkin' that reads a JSON file from the current song folder and applies camera changes such as `set`, `tween`, and `setTween` operations using custom modifiers defined in the JSON.

This system is designed to make camera events easier to manage and customize without hardcoding every movement directly into the engine state.

## Overview

The core idea is simple:

- the game reads a song-specific JSON file
- the file defines camera events and modifiers
- the library processes those instructions at runtime
- the camera is updated through custom event logic based on the current song data

This makes it convenient for creating dynamic camera behavior that can be edited and reused across songs.

## Features

- JSON-driven camera event configuration
- Support for camera modifications like `set`, `tween`, and `setTween`
- Modifiers defined in the JSON file
- Built for use in a FNF-style gameplay flow
- Designed to work around the current song folder data structure

## Important notice

This project currently only works on the Leather Engine.

It is not intended to be used as a universal solution across every FNF engine at the moment, and compatibility with other engines is still limited.

## Quick start

### 1. Install the library from this repository

If you are using this project as a local Haxelib, clone it and register it with Haxe:

```bash
git clone https://github.com/pedrinducavalo/camera-events.git
haxelib dev camera-events ./camera-events
```

If you are already using a local Haxe setup, make sure the repository is available in your Haxe lib path and that the package is recognized by your project.

### 2. Include it in your project

Add the library to your `Project.xml`:

```xml
<haxelib name="camera-events" />
```

If your engine or project setup uses a different project configuration format, the same principle applies: add the library as a Haxelib dependency.

### 3. Instantiate the camera core in `PlayState`

Create a `CameraCore` instance inside your `PlayState` and keep a reference to it:

```haxe
var cameraCore:CameraCore = new CameraCore();
```

This is the main runtime object responsible for reading the song JSON and applying the camera modifications.

### 4. Update the core in `PlayState`

Call the update method during the normal update loop in `PlayState`:

```haxe
cameraCore.update(elapsed);
```

The exact placement depends on how your engine handles its main update loop, but the intent is the same: call the core update every frame while the song is running.

### 5. After that, it is supposed to work

Once the library is included, instantiated, and updated in `PlayState`, the camera system is expected to function as designed. The JSON file in the current song folder should be parsed and its camera instructions should be applied at runtime.

## Expected usage workflow

In practice, the flow is:

1. Place your event JSON in the current song folder
2. Load or reference the song data from the project structure
3. Let `CameraCore` read the JSON
4. Use the configured modifiers to apply camera changes
5. Let the update loop continue to process the events in real time

## Future plans

This project is still in active development, and I plan to expand it in the future.

Planned additions include:

- support for more engines, such as Psych Engine
- improved compatibility beyond Leather Engine
- a dedicated editor to create and edit the JSON files used by this system
- a more user-friendly workflow for designing camera events visually

## Notes

This project is meant to be a simple and flexible camera event tool for FNF modding workflows, especially for projects that want data-driven camera behavior instead of hardcoded logic.

If you are using this with Leather Engine, this setup is the intended path for normal usage.

## License

This project does not currently declare a specific license in the repository metadata, so please check the repo contents and project configuration before redistributing or using it in a production project.

## Contributing

If you want to improve the system, add support for other engines, or help build the JSON editor, contributions are welcome.

However, the current focus remains on making the library usable within the Leather Engine workflow and extending it over time.
