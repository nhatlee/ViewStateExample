//
//  ExampleUseCase.swift
//  ViewStateSwiftUI
//
//  Created by nhatle on 12/16/19.
//  Copyright © 2019 VNG. All rights reserved.
//

import SwiftUI

/*
 That is why the CPU does not go crazy. By assigning the same value it had before, we are breaking the never-ending loop we saw in the previous example.
 */

struct ExampleView2: View {
    @State private var flag = false
    @State private var cardinalDirection = ""
    
    var body: some View {
        
        print("Body called: cardinalDirection = \(cardinalDirection)")
        
        return VStack(spacing: 30) {
            CPUWheel().frame(height: 150)
            
            Text("\(cardinalDirection)").font(.largeTitle)
            Image(systemName: "location.north")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
                .modifier(RotateNeedle(cardinalDirection: self.$cardinalDirection, angle: self.flag ? 0 : 360))
            
            Button("Animate") {
                withAnimation(.easeInOut(duration: 3.0)) {
                    self.flag.toggle()
                }
            }
        }
    }
}

struct RotateNeedle: GeometryEffect {
    @Binding var cardinalDirection: String
    
    var angle: Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        DispatchQueue.main.async {
            DispatchQueue.main.async {
                self.cardinalDirection = self.angleToString(self.angle)
                print("EffectValue called: cardinalDirection = \(self.cardinalDirection)")
            }
        }
        
        let rotation = CGAffineTransform(rotationAngle: CGFloat(angle * (Double.pi / 180.0)))
        let offset1 = CGAffineTransform(translationX: size.width/2.0, y: size.height/2.0)
        let offset2 = CGAffineTransform(translationX: -size.width/2.0, y: -size.height/2.0)
        return ProjectionTransform(offset2.concatenating(rotation).concatenating(offset1))
    }
    
    func angleToString(_ a: Double) -> String {
        switch a {
        case 315..<405:
            fallthrough
        case 0..<45:
            return "North"
        case 45..<135:
            return "East"
        case 135..<225:
            return "South"
        default:
            return "West"
        }
    }
}
