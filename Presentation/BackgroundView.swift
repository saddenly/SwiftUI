//
//  BackgroundView.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 11/09/2025.
//

import SwiftUI

struct BackgroundView: View {
    
    @Binding
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}
