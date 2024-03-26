//
//  NetworkManager.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 27/03/2024.
//
import Network

class NetworkManager {
    static let shared = NetworkManager()
    
    let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connection is available")
            } else {
                print("No internet connection")
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

