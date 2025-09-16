//
//  DateFormatting.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 13/09/2025.
//

import Foundation

protocol DateFormatting {
    func string(fromDate date: Date) -> String
}

struct UnixDateFormatter: DateFormatting {
    func string(fromDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
