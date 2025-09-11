//
//  WeatherRepository.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

public protocol WeatherRepository {
    func currentWeather(latitude: Double, longitude: Double) async throws -> Weather
}
