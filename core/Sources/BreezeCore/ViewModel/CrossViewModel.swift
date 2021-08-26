import Dispatch
import Foundation
import SwiftSoup

#if canImport(Combine)
    import Combine
#else
    import OpenCombine
#endif


//Conditionally import Foundation networking
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

//import BreezeCore.GlobalImport //TODO: figure out how to import everything once
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
    var listener: AnyCancellable?
    
    static var mainer = true
    
    public init(delegate: CrossDelegate, value: String) {
        
        self.delegate = delegate
        data = CrossModelData(string: value)
        
        #if os(Android)
        //send change messages to Android when we need to refresh the UI.
        objectWillChange.subscribe(CoalesceDidChangeSubscriber(delegate))
        #endif

        //becomes: "Main? true"
        self.delegate.onCall(value: "Main? \(Thread.isMainThread)")
        
        // do package dependencies and regular URLSession work?
        let task = URLSession.shared.dataTask(with: URL(string: "https://qvik.com/careers/mobile-developer-ios-android-sweden/")!) { data, response, error in
            
            var message = "There was a parsing error: data is nil? \(data == nil)"
            if let data = data,
               let html = String(data: data, encoding: .utf8),
               let doc: Document = try? SwiftSoup.parse(html),
               let header = try? doc.getElementsByTag("h1").first(),
               let text = try? header.text()
            {
                message = text
            }
            else if let error = error {
                message = "Download error: \(error)"
                if let response = response {
                    message += "\nResponse: \(response)"
                }
            }
            
            self.delegate.onCall(value: message)
            
            // Yes, things work!
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                
                //becomes: "Main? false asyncAfter"
                self.delegate.onCall(value: "Main? \(Thread.isMainThread) asyncAfter")
                
                if let error = error {
                    self.data.string = error.localizedDescription
                }
                else {
                    //Senior Mobile Developers (iOS, Android), Sweden
                    self.data.string = message
                }
                self.delegate.onCall(value: self.data.string)
                self.objectWillChange.send()
            }
        }
        task.resume()
    }
    
    public func getData() -> CrossModelData {
        return data
    }
}
