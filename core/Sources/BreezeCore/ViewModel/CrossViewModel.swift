import Foundation
import Dispatch
import SwiftSoup
#if os(Android)
/*
 we use OpenCombine for ObservableObject
 TODO: use objectWillChange in Android to trigger changes
 Note: before continuing we need to upgrade the toolchain to at least 5.1 for propertyWrappers.
 
 */
import OpenCombine
#endif

public protocol CrossDelegate { 

    func onCall(value: String)
}

public struct CrossModelData: Codable, Hashable {
    
    public init(string: String) {
        self.string = string
    }
    
    public var string: String
    public var subTitle: String = "Subtitle"
}


@available(iOS 13.0, *, macOS 10.15, *)
public class CrossViewModel: ObservableObject {
    
    var delegate: CrossDelegate?
    public var data: CrossModelData
    
    /*
     TODO: before continuing we need to upgrade the toolchain to at least 5.1 for propertyWrappers.
     */
    #if os(Android)
    public var objectWillChange = ObjectWillChangePublisher()
    #endif
    
    public var stringProp: String = "Subtitle"
    public static var staticString: String = "static"
    
    public init(value: String) {
    
        data = CrossModelData(string: value)
        
        // do package dependencies and regular URLSession work?
        let task = URLSession.shared.dataTask(with: URL(string: "https://qvik.com/careers/mobile-developer-ios-android-sweden/")!) { data, response, error in
            
            var message = "There was a parsing error"
            if let data = data,
               let html = String(data: data, encoding: .utf8),
               let doc: Document = try? SwiftSoup.parse(html),
               let header = try? doc.getElementsByTag("h1").first(),
               let text = try? header.text()
            {
                message = text
            }
            
            // Yes, things work!
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                if let error = error {
                    self.data.string = error.localizedDescription
                }
                else {
                    //Senior Mobile Developers (iOS, Android), Sweden
                    self.data.string = message
                }
                self.delegate?.onCall(value: self.data.string)
            }
        }
        task.resume()
    }
    
    public func setDelegate(delegate: CrossDelegate) {
        self.delegate = delegate
    }
    
    public func getData() -> CrossModelData {
        return data
    }
    
    var firstBool = true
    public func trigger() {
        
        if firstBool {
            firstBool = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                if let delegate = self.delegate {
                    self.data.string = "Swift change"
                    delegate.onCall(value: self.data.string)
                }
            }
        }
    }
}
