package com.qvik.breeze.viewModels

import com.readdle.codegen.anotation.SwiftFunc
import com.readdle.codegen.anotation.SwiftReference

import com.readdle.codegen.anotation.*

@SwiftReference
class CrossViewModel private constructor() {

    // Swift JNI private native pointer
    private val nativePointer = 0L

    // Swift JNI release method
    external fun release()

    // properties can be handled like this
    @get:SwiftGetter
    @set:SwiftSetter
    var stringProp: String
        external get
        external set

    // talk to swift is easy, just define a function like this
    @SwiftFunc("trigger()")
    external fun trigger()

    // we can also transfer structs
    @SwiftFunc("getData()")
    external fun getData(): CrossModelData

    // we can call from Swift into Kotlin by implementing a common protocol, here the CrossDelegateAndroid protocol has the "onCall" function
    @SwiftFunc("setDelegate(delegate:)")
    external fun setDelegate(delegate: CrossDelegateAndroid)

    companion object {
        @JvmStatic @SwiftFunc("init(value:)")
        external fun init(value: String): CrossViewModel

        @JvmStatic
        @get:SwiftGetter("staticString")
        @set:SwiftSetter("staticString")
        var staticString: String
            external get
            external set
    }

}

