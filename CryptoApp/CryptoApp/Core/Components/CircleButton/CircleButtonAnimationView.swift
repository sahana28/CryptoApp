//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Sahana  Rao on 15/08/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate : Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 0.8) : .none)
        
          
        
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(false))
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}
