//
//  ContentView.swift
//  ViewStateSwiftUI
//
//  Created by nhatle on 12/16/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import SwiftUI


// MARK: Example 1
struct ContentView: View {
    @State private var showOutOfControlView = false
    var body: some View {
        VStack(spacing:10) {
            CPUWheel().frame(height: 150)
            
            VStack {
                if showOutOfControlView { OutOfControlView() }
            }.frame(height: 80)
            
            Button(self.showOutOfControlView ? "Hide": "Show") {
                self.showOutOfControlView.toggle()
            }
        }
    }
}

// MARK: Modify inside state of view while view is computing
struct OutOfControlView: View {
    @State private var counter = 0
    
    var body: some View {
        DispatchQueue.main.async {
            self.counter += 1
        }
        return Text("Computed Times\n\(self.counter)").multilineTextAlignment(.center)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
