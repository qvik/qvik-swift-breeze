package com.qvik.breeze.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.annotation.DrawableRes
import androidx.recyclerview.widget.RecyclerView

import com.qvik.breeze.R
import com.qvik.breeze.viewModels.CrossDelegateAndroid
import com.qvik.breeze.viewModels.CrossViewModel

import android.os.Handler

class StringAdapter(private var items: List<CrossViewModel>) :
    RecyclerView.Adapter<StringAdapter.StringViewHolder>(), CrossDelegateAndroid 
    {

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder.
    // Each data item is just a string in this case that is shown in a TextView.
    class StringViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val weatherState: ImageView = itemView.findViewById(R.id.weatherState)
        val titleText: TextView = itemView.findViewById(R.id.title)
        val tempText: TextView = itemView.findViewById(R.id.temp)
    }

    // Create new views (invoked by the layout manager)
    override fun onCreateViewHolder(parent: ViewGroup,
                                    viewType: Int): StringViewHolder {

        val textView = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_location, parent, false)
        return StringViewHolder(
            textView
        )
    }

    // Replace the contents of a view (invoked by the layout manager)
    override fun onBindViewHolder(holder: StringViewHolder, position: Int) {

        val item = items[position]
        // stringProp lives in Swift land, we can use it as a regular property
        item.stringProp = "(0_0)"
        item.trigger()
        val data = item.getData()
        holder.titleText.text = data.string
        holder.tempText.text = item.stringProp  // now we retrieve it from Swift, it should be the same as above
        holder.weatherState.setImageResource(R.drawable.ic_c)
    }

    val handler = Handler()

    override 
    fun onCall(value: String) {

        println(value);
    }

        override fun redraw() {
            //If coming from a bg-thread we need to make sure we get back into the UI-thread, otherwise crash - Swift main thread is not usually Kotlin main.
            handler.post({
                notifyDataSetChanged()
            })
        }

    // Return the size of your dataset (invoked by the layout manager)
    override fun getItemCount() = items.size

    fun swapItems(items: List<CrossViewModel>) {
        this.items = items
        notifyDataSetChanged()
    }
/*
    @DrawableRes
    private fun getDrawableForWeatherState(state: WeatherState): Int {
        return when (state) {
            WeatherState.NONE -> R.drawable.ic_sync
            WeatherState.SNOW -> R.drawable.ic_sn
            WeatherState.SLEET -> R.drawable.ic_sl
            WeatherState.HAIL -> R.drawable.ic_h
            WeatherState.THUNDERSTORM -> R.drawable.ic_t
            WeatherState.HEAVY_RAIN -> R.drawable.ic_hr
            WeatherState.LIGHT_RAIN -> R.drawable.ic_lr
            WeatherState.SHOWERS -> R.drawable.ic_s
            WeatherState.HEAVY_CLOUD -> R.drawable.ic_hc
            WeatherState.LIGHT_CLOUD -> R.drawable.ic_lc
            WeatherState.CLEAR -> R.drawable.ic_c
        }
    }

 */
}