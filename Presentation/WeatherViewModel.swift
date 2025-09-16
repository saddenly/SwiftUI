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
    @Published var showNoInternetAlert = false
    private let fetchWeather: FetchWeatherUseCase
    private let tempFormatter: TemperatureFormatting
    private let dateFormatter: DateFormatting
    private let intervalSeconds: UInt64
    private var pollTask: Task<Void, Never>?

    init(
        fetchWeather: FetchWeatherUseCase,
        tempFormatter: TemperatureFormatting,
        dateFormatter: DateFormatting
    ) {
        self.fetchWeather = fetchWeather
        self.tempFormatter = tempFormatter
        self.dateFormatter = dateFormatter
        self.intervalSeconds = 10
    }

    func startPolling(
        immediate: Bool = true,
        latitude: Double,
        longitude: Double
    ) {
        pollTask?.cancel()

        pollTask = Task { [weak self] in
            guard let self else { return }
            if immediate {
                await self.fetchOnce(latitude: latitude, longitude: longitude)
            }

            while !Task.isCancelled {
                try? await Task.sleep(
                    nanoseconds: intervalSeconds * 1_000_000_000
                )

                if case .error = self.state { break }

                await self.fetchOnce(latitude: latitude, longitude: longitude)
            }
        }
    }

    func stopPolling() {
        pollTask?.cancel()
        pollTask = nil
    }

    func retry(latitude: Double, longitude: Double) {
        showNoInternetAlert = false
        state = .loading
        startPolling(immediate: true, latitude: latitude, longitude: longitude)
    }

    private func fetchOnce(latitude: Double, longitude: Double) async {
        do {
            let weather = try await fetchWeather.execute(
                latitude: latitude,
                longitude: longitude
            )
            state = .loaded(
                cityName: weather.cityName,
                cityTemperature:
                    "\(tempFormatter.string(fromCelsius: weather.temperatureCelsius))",
                updatedAt: "\(dateFormatter.string(fromDate: weather.time))"
            )
        } catch {
            if let urlErr = error as? URLError, urlErr.code == .notConnectedToInternet {
                showNoInternetAlert = true
                state = .error(message: "Please check your internet connection")
            } else {
                state = .error(message: humanReadableMessage(error))
            }
            stopPolling()
        }
    }

    private func humanReadableMessage(_ error: Error) -> String {
        (error as? URLError)?.code == .notConnectedToInternet
            ? "No internet connection" : error.localizedDescription
    }
}
