package com.qvik.breeze.viewModels;

import com.readdle.codegen.anotation.SwiftCallbackFunc
import com.readdle.codegen.anotation.SwiftDelegate

@SwiftDelegate(protocols = ["CrossDelegate"])
interface CrossDelegateAndroid { 

    @SwiftCallbackFunc("onCall(value:)")
    fun onCall(value: String)

    companion object {
        
    }
}