//
//  WeatherViewModelTests.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 11/09/2025.
//

import XCTest
@testable import SwiftUI_Weather

@MainActor
final class WeatherViewModelTests: XCTestCase {
    struct RepoStub: WeatherRepository {
        let weather: Weather
        func currentWeather(latitude: Double, longitude: Double) async throws -> Weather {
            weather
        }
    }
    struct TempFormatStub: TemperatureFormatting {func string(fromCelsius c: Double) -> String {
        "20C"
    }}
}
