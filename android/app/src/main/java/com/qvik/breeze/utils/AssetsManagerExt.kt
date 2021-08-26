package com.qvik.breeze.utils

import android.content.res.AssetManager
import android.util.Log
import java.io.*

fun AssetManager.copyAssetsIfNeeded(filename: String, destination: String) {

    var inputStream: InputStream? = null
    var outputStream: OutputStream? = null
    try {
        val outFile = File(destination, filename)
        if (outFile.exists()) {
            return
        }
        val parent = outFile.parentFile
        if (parent != null && !parent.exists() && !parent.mkdirs()) {
            Log.e("breezeApp", "Couldn't create dir: $parent")
            return
        }
        inputStream = open(filename)
        outputStream = FileOutputStream(outFile)
        val buffer = ByteArray(1024)
        var read: Int
        while (inputStream.read(buffer).also { read = it } != -1) {
            outputStream.write(buffer, 0, read)
        }
    } catch (e: IOException) {
        Log.e("breezeApp", "Failed to copy asset file: $filename", e)
    } finally {
        fun closeSilently(closeable: Closeable?) {
            if (closeable != null) {
                try {
                    closeable.close()
                } catch (e: IOException) {
                    e.printStackTrace()
                }
            }
        }
        closeSilently(inputStream)
        closeSilently(outputStream)

        //Log.d("breezeApp", "Copied assets: $filename")
    }

}