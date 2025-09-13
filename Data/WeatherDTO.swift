//
//  WeatherDTO.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 10/09/2025.
//

import Foundation

struct WeatherDTO: Decodable {
    let temp: Double
    let cityName: String
    let time: Double
    
    private enum CodingKeys: String, CodingKey {
        case main
        case name
        case dt
    }
    
    private enum MainKeys: String, CodingKey {
        case temp
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temp = try main.decode(Double.self, forKey: .temp)
        cityName = try container.decode(String.self, forKey: .name)
        time = try container.decode(Double.self, forKey: .dt)
    }
}

extension WeatherDTO {
    func toDomain() -> Weather {
        Weather(temperatureCelsius: temp, cityName: cityName, time: Date(timeIntervalSince1970: time))
    }
}
