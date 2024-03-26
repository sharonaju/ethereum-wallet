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
            case invalidURL
            case invalidResponse
            case requestFailed
            case invalidData
            case serializationError
        }
    
    func callAlchemyAPI(method: String, params: [Any], completion: @escaping (Result<Any, Error>) -> Void) {
        guard let url = URL(string: alchemyBaseUrl + alchemyApiKey) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = [
            "jsonrpc": "2.0",
            "method": method,
            "params": params,
            "id": 1
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
        } catch {
            completion(.failure(APIError.serializationError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
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

                completion(.success(json))
            }
        }.resume()
    }


    func constructURL(endpoint: String, queryParams: [String: String] = [:]) -> URL? {
           var components = URLComponents(string: alchemyBaseUrl + endpoint)
           var queryItems = [URLQueryItem]()
           for (key, value) in queryParams {
               queryItems.append(URLQueryItem(name: key, value: value))
           }
           components?.queryItems = queryItems
           return components?.url
       }
       
       func parseResponse<T>(_ response: Any, parseFunction: (Any) -> T?) -> Result<T, Error> {
           if let parsedResult = parseFunction(response) {
               return .success(parsedResult)
           } else {
               return .failure(APIError.invalidResponse)
           }
       }

   }
