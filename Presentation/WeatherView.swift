//
//  WeatherView.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel
    @State var isNight = false
    let latitude: Double
    let longitude: Double
    
    var body: some View {

            switch viewModel.state {
            case .idle, .loading:
                ProgressView().task {await viewModel.load(latitude: latitude, longitude: longitude)}
            case .loaded(let cityName, let cityTemperature, _):
                ZStack {
                    BackgroundView(isNight: $isNight)
                    
                    VStack {
                        CityTextView(cityName: cityName)
                        
                        MainWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: cityTemperature)
                        .padding(.bottom, 40)
                        
                        Spacer()
                        
                        Button {
                            isNight.toggle()
                        } label: {
                            WeatherButton(title: "Change Day Time",
                                          textColor: .blue,
                                          backgroundColor: .white)
                        }
                        
                        Spacer()
                    }
                }
            case .error(let msg):
                VStack(spacing: 12) {
                    Text(msg)
                    Button("Retry") {Task {await viewModel.load(latitude: latitude, longitude: longitude)}}
                }
            }
        }
}
