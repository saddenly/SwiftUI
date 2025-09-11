//
//  WeatherRepositoryImpl.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

final class WeatherRepositoryImpl: WeatherRepository {
    private let api: WeatherAPI

    init(api: WeatherAPI) {
        self.api = api
    }
    
    func currentWeather(latitude: Double, longitude: Double) async throws -> Weather {
        let dto = try await api.fetchCurrentWeather(latitude: latitude, longitude: longitude)
        return dto.toDomain()
    }
}
