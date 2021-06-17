import XCTest
@testable import BreezeCore

class CrossingTest: XCTestCase {

    func testSearchLocationsSuccessful() {
        
        let delagate = FakeDelagate(expectation(description: "onCall should be called"))
        let model = CrossViewModel(value: "testing")
        model.delegate = delagate
        wait(for: [delagate.expect], timeout: 3.0)
    }

    class FakeDelagate: CrossDelegate {
        
        let expect: XCTestExpectation
        init(_ expect: XCTestExpectation) {
            
            self.expect = expect
        }
        
        func onCall(value: String) {
            
            expect.fulfill()
        }
        /*
         #if os(Android)
         XCTAssertEqual(errorDescription, "The operation could not be completed. ( error 0.)")
         #else
         XCTAssertEqual(errorDescription, "The operation couldn’t be completed. ( error 0.)")
         #endif
         */
    }
}
