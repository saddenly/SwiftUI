//
//  NetworkMonitor.swift
//  SwiftUI-Weather
//
//  Created by Rustem Andassov on 15/09/2025.
//

import Network
import Foundation

@MainActor
final class NetworkMonitor: ObservableObject {
    @Published private(set) var isConnected: Bool = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init () {
        monitor.pathUpdateHandler = { [weak self] path in
            Task {@MainActor in
                self?.isConnected = (path.status == .satisfied)
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit { monitor.cancel()}
}
