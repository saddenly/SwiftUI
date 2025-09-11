//
//  MainWeatherStatusView.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 11/09/2025.
//

import SwiftUI

struct MainWeatherStatusView : View {
    
    var imageName: String
    var temperature: String
    
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text(temperature)
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
    }
}
