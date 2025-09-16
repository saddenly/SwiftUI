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
    struct DateFormatStub: DateFormatting { func string(fromDate date: Date) -> String {
        "09:55:04"
    }}
    
    func test_load_success() async {
        let weather = Weather(temperatureCelsius: 20, cityName: "Rzeszow", time: Date())
        let useCase = FetchWeatherUseCase(repository: RepoStub(weather: weather))
        let viewModel = WeatherViewModel(fetchWeather: useCase, tempFormatter: TempFormatStub(), dateFormatter: DateFormatStub())
        
        viewModel.startPolling(latitude: 50.03, longitude: 22.00)
        XCTAssertEqual(viewModel.state, .loaded(cityName: "Rzeszow", cityTemperature: "20C", updatedAt: "09:55:04"))
    }
}
