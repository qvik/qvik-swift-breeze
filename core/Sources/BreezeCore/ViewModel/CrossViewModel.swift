import Dispatch
import Foundation
import SwiftSoup
//import BreezeCore.GlobalImport

public protocol CrossDelegate { 

    func onCall(value: String)
    func redraw()
}

public struct CrossModelData: Codable, Hashable {
    
    public init(string: String) {
        self.string = string
    }
    
    public var string: String
    public var subTitle: String = "Subtitle"
}

public class CrossViewModel: ObservableObject {
    
    let delegate: CrossDelegate
    public var data: CrossModelData
    
    @Published public var stringProp: String = "Subtitle"
    public static var staticString: String = "This string is static!"
    
    public init(delegate: CrossDelegate, value: String) {
    
        self.delegate = delegate
        data = CrossModelData(string: value)
        
        #if os(Android)
        //only needed for android
        objectWillChange.subscribe(CoalesceDidChangeSubscriber(delegate))
        #endif
        
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
                self.delegate.onCall(value: self.data.string)
            }
        }
        task.resume()
    }
    
    public func getData() -> CrossModelData {
        return data
    }
    
    var firstBool = true
    public func trigger() {
        
        if firstBool {
            firstBool = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                
                self.data.string = "Swift change"
                self.delegate.onCall(value: self.data.string)
                
            }
        }
    }
}
