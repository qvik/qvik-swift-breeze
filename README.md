# Swift for Android quick start ![AndroidCore](https://github.com/andriydruk/swift-weather-app/workflows/AndroidCore/badge.svg)

This is an example of how to build a cross-platform Swift application for both Android and iOS. 

Its simplified version taken from [Andriy Druk's Swift Weather App](https://github.com/andriydruk/swift-weather-app) to be used as a starting point, or when creating Android versions of your own existing projects.

## How to build [Android]

Start by installing [Readdle's Swift Android Toolchain](https://github.com/readdle/swift-android-toolchain#installation). Basically you need to install the NDK, the toolchain and the Swift version used to build the toolchain.
After a successful setup, you can clone this repo and build it with Android Studio as any other android project.

Note: If Android studio fails to read your path-settings, you can force it by creating a local.properties file and supplying the paths:
```
sdk.dir=/path/goes/here
ndk.dir=/path/goes/here
swift-android.dir=/path/goes/here
```

## How to build [iOS/MacOS]

The package is used just like any other external framework, its just to build and run.
Note that nothing is built for these platforms yet, all focus is on getting things running smoothly on Android.

## How to build for Windows, Browsers and Linux

Swift is supported on these platforms as well, so there is nothing stopping anyone - but at the moment the focus is on iOS and Android.

# Help / Knowledge

Best sources are the swift dev forums, and the wonderful people in this thread: https://forums.swift.org/t/partial-nightlies-for-android-sdk/


## Architecture

Architecture based on reusing as much as possible code written on Swift. All platform independent functionality is within a "core", which can be shared among all platforms. On each platform you build interfaces which gets called from this core whenever states have changed, or calls into this core to trigger changes. Basically everything except platform specific code like UI, location and app life cycle events can be included in the core. 

When building UI, one easy way is to use the MVVM architecture, and have everything but the view shared. The view model gets an Android interface by writing an annotated Kotlin class (JNI-stub). These stubs create Kotlin classes that work well with the underlying Swift runtime, and lets you share everything but the UI.

For a more in-depth example, you can look at this: https://github.com/android/architecture-samples/tree/todo-mvvm-databinding

## JNI-Stubs

The stubs are a lightweight representation of the JNI-code needed to bridge the gap between native and JVM. From these the build system can generate the rest, which is great since it is repetitive and error prone boilerplate code. Even these stubs can probably be generated automatically but out of scope for now. For more details on how to annotate your code, see [the AnnotaionDocs](doc/AnnotaionDocs.md)

