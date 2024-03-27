//
//  NetworkManager.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//
import Network

import Network

class NetworkManager {
    static let shared = NetworkManager()
    
    let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    private(set) var isMonitoringStarted: Bool = false
    var currentPathStatus: NWPath.Status = .unsatisfied
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        isMonitoringStarted = true
        monitor.pathUpdateHandler = { [weak self] path in
            self?.currentPathStatus = path.status
            if path.status == .satisfied {
                print("Internet connection is available")
            } else {
                print("No internet connection")
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
        isMonitoringStarted = false
    }
}
