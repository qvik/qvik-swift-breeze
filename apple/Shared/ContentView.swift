//
//  ContentView.swift
//  Shared
//
//  Created by Andrius Shiaulis on 04.07.2020.
//

import SwiftUI
import BreezeCore

struct ContentView: View {
    
    @ObservedObject
    var model = CrossViewModel(value: "Breeze")
    
    var body: some View {
        VStack {
            Text(model.data.string)
                .padding()
            Text(model.stringProp)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
