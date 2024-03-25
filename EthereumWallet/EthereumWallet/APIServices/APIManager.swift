//
//  APIManager.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 25/03/2024.
//


import Foundation

class APIManager {
    static let shared = APIManager()
    
    private let alchemyApiKey = "I4PcVMNyvfq_Ex7y3p2Y2dUSzkl9pBlh"
    private let alchemyBaseUrl = "https://eth-mainnet.alchemyapi.io/v2/"
    
    enum APIError: Error {
        case invalidResponse
        case requestFailed
        case invalidData
    }
    
    func callAlchemyAPI(method: String, params: [Any], completion: @escaping (Result<Any, Error>) -> Void) {
        let url = URL(string: alchemyBaseUrl + alchemyApiKey)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "id": 1
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        // Print the request
        if let requestBody = String(data: jsonData, encoding: .utf8) {
            print("Request: \(requestBody)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(.failure(APIError.invalidResponse))
                return
            }

            // Print the response
            print("Response: \(json)")
//            if let jsonResponse = json {
//                print("Response: \(jsonResponse)")
//            }

            completion(.success(json))
        }.resume()
    }

}
