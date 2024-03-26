//
//  FetchWalletBalanceUseCase.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 26/03/2024.
//

import Foundation
class FetchWalletBalanceUseCase {
    
    var walletAddress = ""
    var apiManager = APIManager()
    
    init(walletAddress: String = "", apiManager: APIManager) {
        self.walletAddress = walletAddress
        self.apiManager = apiManager
    }

    func fetch(completion: @escaping (Result<String, Error>) -> Void) {
        apiManager.callAlchemyAPI(method: "eth_getBalance", params: [walletAddress, "latest"]) { result in
            switch result {
            case .success(let response):
                let parseResult: Result<String, Error> = self.apiManager.parseResponse(response, parseFunction: self.parseBalance)
                switch parseResult {
                case .success(let balance):
                    let balanceInEther = self.convertWeiToEther(weiHex: balance)
                    print("Wallet Balance: \(balanceInEther) ETH")
                    completion(.success(balanceInEther))
                case .failure(let error):
                    print("Error parsing balance: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                // Handle API call error
                print("Error fetching wallet balance: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    private func parseBalance(_ response: Any) -> String? {
        guard let responseDict = response as? [String: Any],
              let result = responseDict["result"] as? String else {
            return nil
        }
        return result
    }
    
    func convertWeiToEther(weiHex: String) -> String {
        let weiString = String(weiHex.dropFirst(2)) // Remove the "0x" prefix
        var weiDecimal = Decimal(0)
        
        for char in weiString {
            guard let digit = UInt64(String(char), radix: 16) else {
                return "Invalid input"
            }
            weiDecimal = weiDecimal * 16 + Decimal(digit)
        }

        let divisor = Decimal(sign: .plus, exponent: 18, significand: Decimal(1))
        var etherDecimal = weiDecimal / divisor

        // Round to a maximum of 3 decimal places
        var roundedEther = Decimal()
        NSDecimalRound(&roundedEther, &etherDecimal, 3, .plain)

        return NSDecimalNumber(decimal: roundedEther).stringValue
    }

}
