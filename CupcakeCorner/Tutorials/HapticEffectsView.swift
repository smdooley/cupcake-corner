//
//  HapticEffectsView.swift
//  CupcakeCorner
//
//  Created by Sean Dooley on 26/11/2024.
//

import SwiftUI

struct HapticEffectsView: View {
    @State private var counter = 0

    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
        // middling collision between two soft objects
//        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
        // intense collision between two heavy objects
//        .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
    }
}

#Preview {
    HapticEffectsView()
}
