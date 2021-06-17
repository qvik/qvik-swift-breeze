// Generated using JavaSwift codegen by Sourcery
// DO NOT EDIT

package com.qvik.breeze.core;

import com.readdle.codegen.anotation.SwiftFunc
import com.readdle.codegen.anotation.SwiftReference

@SwiftReference
class SSLHelper private constructor() {

    // Swift JNI private native pointer
    private val nativePointer = 0L

    // Swift JNI release method
    external fun release()

    companion object {
        @JvmStatic @SwiftFunc("setupCert(basePath:)")
		external fun setupCert(basePath: String)
    }

}