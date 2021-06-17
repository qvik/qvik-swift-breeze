# Communication Swift - Java Virtual Machine

Since Swift on Android is compiled and run at the native side, communication is done via the Java Native Interface (JNI). Basically all classes and functions that trancends the boundry need an interface so the JVM know how to handle it. Usually this is quite labour intensive and error-prone, but since we have the SwiftAnnotations it is almost automatic. All we need to do is write a Kotlin "header" with annotated functions/classes, and the build system handles the rest for us.

Note that these headers can/should be generated automatically by the build system also, so that in the future you will not need to deal with this at all.

# SwiftAnnotations

For a complete rundown of all types and how to use them, look at the SwiftAnnotation sample:
Kotlin:
https://github.com/readdle/swift-java-codegen/blob/c98b1273465211478a5387a63a74a4e3338b44bb/sample/src/main/java/com/readdle/swiftjava/sample/SampleReference.kt
Swift:
https://github.com/readdle/swift-java-codegen/blob/c98b1273465211478a5387a63a74a4e3338b44bb/sample/src/main/swift/Sources/SampleAppCore/SampleReference.swift


Here are the most common types and their usage:

Declaring a property in a class (get/set)
    @get:SwiftGetter
    @set:SwiftSetter

Declaring a class (reference type)
    @SwiftReference

Declaring a value type (struct)
    @SwiftValue

Calling into a Swift function from Kotlin:
    @SwiftFunc("funcitonName(param:)")
    external fun funcitonName(param: paramType)

Calling into Kotlin from Swift:
    @SwiftCallbackFunc("functionName(paramName:)")
    fun functionName(paramName: paramType)

Declaring a protocol to be implemented separately in Kotlin and in Swift for platform dependant functionality:
    @SwiftDelegate(protocols = ["ProtocolName"])

# Examples

## @SwiftReference @SwiftFunc @SwiftGetter

To use a Swift class in Kotlin, use @SwiftReference. To call a function in Swift from Kotlin, use @SwiftFunc. Like this:

``` Swift

import Foundation
import Dispatch

public struct CrossData: Codable {
    public var label = "Crossing data!"
}

public class CrossViewModel {

    public init() {
    }

    public var delegate: CrossDelegate?
    private var data = CrossData()
    public var stringProp: String = ""

    public func getString() -> String {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.data.label = "after change"
            self.delegate?.onCall(value: "change")
        }
        
        return data.label
    }
}
```

``` Kotlin

import com.readdle.codegen.anotation.SwiftFunc
import com.readdle.codegen.anotation.SwiftReference

@SwiftReference
class CrossViewModel private constructor() {

    // Swift JNI private native pointer
    private val nativePointer = 0L

    // Swift JNI release method
    external fun release()

    // declare a variable for the Kotlin implementation of a Swift protokoll
    var delegate: CrossDelegateAndroid? = null


    // an example of a function returning a string 
    @SwiftFunc("getString()")
    external fun getString(): String

    // declaring a property with a getter and a setter
    @get:SwiftGetter
    @set:SwiftSetter
    var stringProp: String
        external get
        external set

    // This is how you declare the init method, if you need to call it from Kotlin
    companion object {
        @JvmStatic @SwiftFunc("init()")
        external fun init(): CrossViewModel
    }

}
```

Notice that CrossData is not exposed to Kotlin since it's not needed. Via the JNI you are free to expose only what you want.

## @SwiftValue

To use a value type annotate it with swift value

``` Swift

public struct Location: Codable, Hashable {
    public let woeId: Int64
    public let title: String
    public let latitude: Float
    public let longitude: Float
}

```

``` Kotlin

import android.os.Parcelable
import kotlinx.android.parcel.Parcelize
import com.readdle.codegen.anotation.SwiftValue

@SwiftValue @Parcelize
data class Location(
        var woeId: Long = 0,
		var title: String = "",
		var latitude: Float = 0.0f,
		var longitude: Float = 0.0f
): Parcelable
```

This becomes a Java file and can now be used as any other Kotlin class, and transend the JVM boundries.

## @SwiftCallbackFunc and @SwiftDelegate

To call from Swift into Kotlin, use @SwiftDelegate and to annotate a callback function use @SwiftCallbackFunc.

``` Swift

public protocol CrossDelegate { 

    func onCall(value: String)
}
```

``` Kotlin

import com.readdle.codegen.anotation.SwiftCallbackFunc
import com.readdle.codegen.anotation.SwiftDelegate

@SwiftDelegate(protocols = ["CrossDelegate"])
interface CrossDelegateAndroid { 

    @SwiftCallbackFunc("onCall(value:)")
    fun onCall(value: String)

    companion object {
        
    }
}
```

Then you just need to implement this interface. 

``` Kotlin

class SomeClassWeImplement() : CrossDelegateAndroid {

    override fun onCall(value: String) {

        //Do work when getting called from Swift
    }
}
```

NOTE: Callbacks must always have a parameter. Automatic JNI generation cannot deal with a function without parameters of some obscure reason.