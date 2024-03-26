//
//  Mock.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import Foundation

class MockAPIManager: APIManager {
    
    var mockResponse: [String: Any]?
    var mockError: Error?
    
    override func callAlchemyAPI(method: String, params: [Any], completion: @escaping (Result<Any, Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let response = mockResponse {
            completion(.success(response))
        } else {
            completion(.failure(APIError.invalidResponse))
        }
    }
}
