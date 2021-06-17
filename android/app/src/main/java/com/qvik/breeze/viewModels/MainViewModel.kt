package com.qvik.breeze

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class MainViewModel {

    private val liveData = MutableLiveData<List<String>>()

    fun getLiveData() : LiveData<List<String>> {
        return liveData
    }
}