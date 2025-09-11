//
//  WeatherAPI.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

import Foundation

protocol WeatherAPI {
    func fetchCurrentWeather (latitude: Double, longitude: Double) async throws -> WeatherDTO
}

final class WeatherAPICLient: WeatherAPI {
    private let session: URLSession
    private let baseURL: URL
    
    init(session: URLSession = .shared, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func fetchCurrentWeather(latitude: Double, longitude: Double) async throws -> WeatherDTO {
        var comps = URLComponents(url: baseURL.appendingPathComponent("/data/2.5/weather"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [.init(name: "lat", value: String(latitude)),
                            .init(name: "lon", value: String(longitude)),
                            .init(name: "units", value: "metric"),
                            .init(name: "appid", value: "12553056f7cb53b44243a5dd57d02ecc")]
        
        let (data, _) = try await session.data(from: comps.url!)
        return try JSONDecoder().decode(WeatherDTO.self, from: data)
    }
}
