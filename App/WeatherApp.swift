//
//  WeatherApp.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let baseUrl = URL(string: "https://api.openweathermap.org")!
            let api = WeatherAPICLient(baseURL: baseUrl)
            let repo = WeatherRepositoryImpl(api: api)
            let useCase = FetchWeatherUseCase(repository: repo)
            let viewModel = WeatherViewModel(fetchWeather: useCase, tempFormatter: TemperatureFormatterCelsius())
            WeatherView(viewModel: viewModel, latitude: 50.03, longitude: 22.00)
        }
    }
}
