package com.qvik.breeze

import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.SearchView
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.snackbar.Snackbar
import dagger.hilt.android.AndroidEntryPoint
import androidx.lifecycle.MutableLiveData

import android.os.Handler

import com.qvik.breeze.adapters.StringAdapter
import com.qvik.breeze.viewModels.*

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    private lateinit var recycler: RecyclerView
    private lateinit var stringAdapter: StringAdapter

    private val liveData = MutableLiveData<List<CrossViewModel>>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val viewManager = LinearLayoutManager(this)
        stringAdapter = StringAdapter(emptyList())

        recycler = findViewById<RecyclerView>(R.id.recycler_view).apply {
            // use this setting to improve performance if you know that changes
            // in content do not change the layout size of the RecyclerView
            setHasFixedSize(true)

            // use a linear layout manager
            layoutManager = viewManager

            // specify an viewAdapter (see also next example)
            adapter = stringAdapter
        }

        liveData.observe(this, {
            stringAdapter.swapItems(it)
        })

        val list = ArrayList<CrossViewModel>()
        val item = CrossViewModel.init("First item")
        item.setDelegate(stringAdapter)
        list.add(item)
        
        list.add(CrossViewModel.init("Second item"))

        liveData.postValue(list)
    }
}
