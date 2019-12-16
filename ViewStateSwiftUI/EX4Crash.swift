//
//  EX4Crash.swift
//  ViewStateSwiftUI
//
//  Created by nhatle on 12/16/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import SwiftUI

// MARK: -crash version

//class MyObservable: ObservableObject {
//    @Published var someValue = "Here's a value!"
//}
//
//struct Ex4CrashView: View {
//    var body: some View {
//        MyView()
//    }
//}
//
//struct MyView: View {
//    @EnvironmentObject var model: MyObservable
//
//    var body: some View {
//        return Text(model.someValue)
//    }
//}


// MARK: -Safe version

class MyObservable: ObservableObject {
    @Published var someValue = "Here's a value!"
}

struct Ex4CrashView: View {
    var body: some View {
        VStack(spacing: 20) {
            MyView()
            
            MyView()
                .environmentObject(MyObservable())
        }
    }
}

struct MyView: View {
    @EnvironmentObject var model: MyObservable

    var body: some View {

        let txt = _model.safeToUse ? model.someValue : "No Value"
        
        return Text(txt)
    }
}
