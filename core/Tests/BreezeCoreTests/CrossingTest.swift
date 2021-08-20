import XCTest
@testable import BreezeCore

class CrossingTest: XCTestCase {
    
    var androidListener: AnyCancellable? = nil
    func testAndroidPub() {
        
        let newValue = "only one message after change"
        let delegate = FakeDelegate(expectation(description: "stringProp should be \(newValue) only"))
        let model = CrossViewModel(delegate: delegate, value: "testing")
        let expect = delegate.expect
        delegate.redrawClosure = {
            print("got value \(model.stringProp)")
            if model.stringProp == newValue {
                expect.fulfill()
            }
        }
        //to test on iOS we need to add this - otherwise we only add on Android
        #if !os(Android)
        model.objectWillChange.subscribe(CoalesceDidChangeSubscriber(delegate))
        #endif
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            model.stringProp = "keeping alive?"
            
            DispatchQueue.main.async {
                model.stringProp = "newValue"
                model.stringProp = "newValue2"
                model.stringProp = newValue
            }
        }
        
        wait(for: [expect], timeout: 3.0)
    }

    func testDownloadAndSoup() {
        
        let delegate = FakeDelegate(expectation(description: "onCall should be called"))
        delegate.onCallClosure = { value in
            if value == "Senior Mobile Developers (iOS, Android), Sweden" {
                delegate.expect.fulfill()
            }
        }
        let model = CrossViewModel(delegate: delegate, value: "testing")
        
        wait(for: [delegate.expect], timeout: 3.0)
        print("done: \(model.stringProp)")
    }

    class FakeDelegate: CrossDelegate {
        
        let expect: XCTestExpectation
        var redrawClosure: (() -> Void)?
        var onCallClosure: ((String) -> Void)?
        init(_ expect: XCTestExpectation) {
            
            self.expect = expect
        }
        
        func onCall(value: String) {
            print("Recieving value: \(value)")
            onCallClosure?(value)
        }
        
        func redraw() {
            //print("Redraw yourself")
            redrawClosure?()
        }
    }
}
