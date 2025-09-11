//
//  TemperatureFormatting.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

protocol TemperatureFormatting {
    func string(fromCelsius c: Double) -> String
}

struct TemperatureFormatterCelsius: TemperatureFormatting {
    func string(fromCelsius c: Double) -> String {
        String(format: "%.0f°C", c)
    }
}
