//
//  WeatherViewModel.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

import SwiftUI

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var state: WeatherViewState = .idle
    private let fetchWeather: FetchWeatherUseCase
    private let tempFormatter: TemperatureFormatting
    
    init(fetchWeather: FetchWeatherUseCase, tempFormatter: TemperatureFormatting) {
        self.fetchWeather = fetchWeather
        self.tempFormatter = tempFormatter
    }
    
    func load(latitude: Double, longitude: Double) async {
        state = .loading
        do {
            let w = try await fetchWeather.execute(latitude: latitude, longitude: longitude)
            let cityName = w.cityName
            let cityTemperature = "\(tempFormatter.string(fromCelsius: w.temperatureCelsius))"
            let weatherIcon = w.temperatureCelsius < 0 ? "❄️" : "☀️"
            state = .loaded(cityName: cityName, cityTemperature: cityTemperature, weatherIcon: weatherIcon)
        } catch {
            state = .error(message: "Failed to load weather")
        }
    }
}
