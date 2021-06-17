package com.qvik.breeze.viewModels

import android.os.Parcelable
import com.readdle.codegen.anotation.SwiftValue
import kotlinx.android.parcel.Parcelize

@SwiftValue @Parcelize
data class CrossModelData(
		var string: String = "",
		var subTitle: String = ""
): Parcelable