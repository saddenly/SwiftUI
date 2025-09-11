//
//  FetchWeatherUseCaseTests.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 11/09/2025.
//

import XCTest
@testable import SwiftUI_Weather

final class FetchWeatherUseCaseTests: XCTestCase {
    struct RepoStub: WeatherRepository {
        var result: Result<Weather, Error>
        func currentWeather(latitude: Double, longitude: Double) async throws -> Weather {
            try result.get()
        }
    }
    
    func test_ReturnsWeather() async throws {
        let expected = Weather(temperatureCelsius: 20, cityName: "Warsaw")
        let sut = FetchWeatherUseCase(repository: RepoStub(result: .success(expected)))
        let w = try await sut.execute(latitude: 20, longitude: 20.5)
        XCTAssertEqual(w, expected)
    }
}
