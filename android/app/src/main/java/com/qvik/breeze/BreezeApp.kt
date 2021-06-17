package com.qvik.breeze

import android.app.Application
import com.readdle.codegen.anotation.JavaSwift
import dagger.hilt.android.HiltAndroidApp
import com.qvik.breeze.core.SSLHelper
import com.qvik.breeze.utils.copyAssetsIfNeeded

@HiltAndroidApp
class BreezeApp: Application() {

    override fun onCreate() {
        super.onCreate()
        System.loadLibrary("BreezeCoreBridge")
        JavaSwift.init()
        assets.copyAssetsIfNeeded("cacert.pem", dataDir.absolutePath)
        SSLHelper.setupCert(dataDir.absolutePath)
    }

}