//
//  FetchWeatherUseCase.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

public struct FetchWeatherUseCase {
    private let repository: WeatherRepository

    public init(repository: WeatherRepository) {
        self.repository = repository
    }

    public func execute(latitude: Double, longitude: Double) async throws
        -> Weather
    {
        try await repository.currentWeather(
            latitude: latitude,
            longitude: longitude
        )
    }
}
