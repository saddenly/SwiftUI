//
//  CityTextView.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 11/09/2025.
//

import SwiftUI

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}
