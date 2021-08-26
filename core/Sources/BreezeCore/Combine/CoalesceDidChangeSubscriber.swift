//
//  CoalesceDidChangeSubscriber.swift
//
//  Created by Olof Thorén on 2021-08-20.
//
import Foundation
import Dispatch

#if canImport(Combine)
    import Combine
#else
    import OpenCombine
#endif

//Conditionally import Foundation networking
#if canImport(FoundationNetworking)
    //@_exported import FoundationNetworking
#endif


/// To notify Android's JVM of changes we coalesce all notifications of changed properties into one message, and just send it to our redraw delegate
class CoalesceDidChangeSubscriber: Subscriber {

    typealias Input = Void
    typealias Failure = Never
    
    let delegate: CrossDelegate
    init(_ delegate: CrossDelegate) {
        self.delegate = delegate
    }
    
    var coalesce = false
    func receive(_ input: Void) -> Subscribers.Demand {
        
        // All UI changes must happen on the main thread on iOS, we use the same model on android, which means that a simply main.async will coalesce all changes and cause only one singe response.
        if coalesce {
            return .none
        }
        coalesce = true
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.coalesce = false
            self.delegate.redraw()
        }
        return .none
    }

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(completion: Subscribers.Completion<Never>) {
    }
}
