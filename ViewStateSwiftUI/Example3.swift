//
//  Example3.swift
//  ViewStateSwiftUI
//
//  Created by nhatle on 12/16/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import SwiftUI

struct ExampleView3: View {
    @State private var width: CGFloat = 0.0
    
    var body: some View {
        Text("Width = \(width)")
            .font(.largeTitle)
//        .font(.custom("Menlo", size: 32))
            .background(WidthGetter(width: self.$width))
    }
    
    struct WidthGetter: View {
        @Binding var width: CGFloat
        
        var body: some View {
            GeometryReader { proxy -> AnyView in
                DispatchQueue.main.async {
                    self.width = proxy.frame(in: .local).width
                }
                return AnyView(Color.clear)
            }
        }
    }
}
