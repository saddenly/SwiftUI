//
//  WeatherViewState.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

enum WeatherViewState: Equatable {
    case idle
    case loading
    case loaded(cityName: String, cityTemperature: String, updatedAt: String)
    case error(message: String)
}
