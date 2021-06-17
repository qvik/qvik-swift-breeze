# Swift for Android quick start ![AndroidCore](https://github.com/andriydruk/swift-weather-app/workflows/AndroidCore/badge.svg)

This is an example of how to build a cross-platform Swift application for both Android and iOS. 

Its simplified version taken from [Andriy Druk's Swift Weather App](https://github.com/andriydruk/swift-weather-app) to be used as a starting point, or when creating Android versions of your own existing projects.

## Architecture

Architecture based on reusing as much as possible code written on Swift. All platform independent functionality is within a "core", which can be shared among all platforms. On each platform you build interfaces which calls into this core, or gets called from this core. Basically everything except platform specific code like UI, location and app life cycle events can be included in the core. 

When building UI, one easy way is to use the MVVM architecture, and share the view model by just supplying an Android interface (JNI-stub). These stubs create Kotlin classes that work well with the underlying Swift runtime, and lets you share everything but the UI.

For a more in-depth example, you can look at this: https://github.com/android/architecture-samples/tree/todo-mvvm-databinding

## JNI-Stubs

The stubs are a lightweight representation of the JNI-code needed to bridge the gap between native and JVM. From these the build system can generate the rest, which is great since it is repetitive and error prone boilerplate code. Even these stubs can probably be generated automatically but out of scope for now. For more details on how to annotate your code, see [the AnnotaionDocs](doc/AnnotaionDocs.md)

## How to build [Android]

For building an Android application this way you need [Readdle's Swift Android Toolchain](https://github.com/readdle/swift-android-toolchain#installation). Please follow the guideline on installation first. If you download the prebuilt toolchain you only need to do "Prepare environment".
After a successful setup, you can clone this repo and build it with Android Studio as any other android project. 


## How to build [iOS/MacOS]

Note that nothing is built for these platforms yet, all focus is on getting things running smoothly on Android.

For building an iOS application you need at least Xcode 12. Minimal target version of operation systems is iOS 14 and MacOS 11. Minimal target can be lower if you build a separate UI for iOS/mac as well.

## How to build for Windows, Browsers and Linux

Swift is supported on these platforms as well, so there is nothing stopping anyone - but at the moment we focus on iOS and Android.
