//
//  FetchTransactionCountUseCase.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import Foundation
class FetchWalletTransactionsCountUseCase {
    
    var walletAddress = ""
    var apiManager = APIManager()
    
    init(walletAddress: String = "", apiManager: APIManager) {
        self.walletAddress = walletAddress
        self.apiManager = apiManager
    }
    
    func fetch(completion: @escaping (Result<Int, Error>) -> ()) {
        apiManager.callAlchemyAPI(method: "eth_getTransactionCount", params: [walletAddress, "latest"]) { result in
            switch result {
            case .success(let response):
                let parseResult: Result<String, Error> = self.apiManager.parseResponse(response, parseFunction: self.parseTransactionsCount)
                switch parseResult {
                case .success(let count):
                    let transactionsCount = self.convertHexToInteger(hex: count) ?? 0
                    completion(.success(transactionsCount))
                case .failure(let error):
                    completion(.failure(error))
                }
            case .failure(let error):
                // Handle API call error
                print("Error fetching wallet balance: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func parseTransactionsCount(_ response: Any) -> String? {
         guard let responseDict = response as? [String: Any],
               let result = responseDict["result"] as? String else {
             return nil
         }
         return result
     }
    
    private func convertHexToInteger(hex: String) -> Int? {
        if let transactionCount = Int(hex.dropFirst(2), radix: 16) {
            return transactionCount
        } else {
            return nil
        }
    }
}
