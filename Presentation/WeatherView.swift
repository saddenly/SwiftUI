//
//  WeatherView.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var net: NetworkMonitor
    @StateObject var viewModel: WeatherViewModel
    @State var isNight = false
    let latitude: Double
    let longitude: Double
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
        case .loaded(let cityName, let cityTemperature, let updatedAt):
            WeatherContentView(
                isNight: $isNight,
                cityName: cityName,
                cityTemperature: cityTemperature,
                updatedAt: updatedAt
            )
        case .error(let msg):
            ProgressView()
            //            Text(msg)
            //            Button("Retry") {
            //                Task {
            //                    viewModel.retry(latitude: latitude, longitude: longitude)
            //                }
            //            }
        }
    }
    
    var body: some View {
        content
            .task {
                viewModel.startPolling(
                    immediate: true,
                    latitude: latitude,
                    longitude: longitude
                )
            }
            .onDisappear {
                viewModel.stopPolling()
            }
            .alert("No Internet Connection", isPresented: Binding(get: {viewModel.showNoInternetAlert || !net.isConnected},
                                                                  set: {_ in viewModel.showNoInternetAlert = false}),
                   actions: {
                Button("Retry") { viewModel.retry(latitude: latitude, longitude: longitude)}
                Button("Cancel", role: .cancel) {}
            })
    }
}

struct WeatherContentView: View {
    @Binding var isNight: Bool
    let cityName: String
    let cityTemperature: String
    let updatedAt: String
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                Spacer()
                
                CityTextView(cityName: cityName)
                
                MainWeatherStatusView(
                    imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                    temperature: cityTemperature,
                    updatedAt: updatedAt
                )
                .padding(.bottom, 40)
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(
                        title: "Change Day Time",
                        textColor: .blue,
                        backgroundColor: .white
                    )
                }
                
                Spacer()
            }
        }
    }
}

struct ErrorView: View {
    let errorMessage: String
    
    var body: some View {
        VStack(spacing: 12) {
            Text(errorMessage)
        }
    }
}
