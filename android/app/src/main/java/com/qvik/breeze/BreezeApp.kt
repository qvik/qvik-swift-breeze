package com.qvik.breeze

import android.app.Application
import com.readdle.codegen.anotation.JavaSwift
import dagger.hilt.android.HiltAndroidApp
import com.qvik.breeze.core.SSLHelper
import com.qvik.breeze.utils.copyAssetsIfNeeded
import android.util.Log
import kotlin.concurrent.thread

@HiltAndroidApp
class BreezeApp: Application() {

    override fun onCreate() {
        super.onCreate()

        var sleep = true
        thread {
            System.loadLibrary("BreezeCoreBridge")
            JavaSwift.init()
            sleep = false

            Log.d("breezeApp", "exiting now")
        }
        while (sleep) {
            //Wait for swift to setup
        }
        Log.d("breezeApp", "swift is setup")
        //Copy certs for SSL
        assets.copyAssetsIfNeeded("cacert.pem", dataDir.absolutePath)
        SSLHelper.setupCert(dataDir.absolutePath)
    }
}

