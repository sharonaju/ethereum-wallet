//
//  WalletBalanceResponse.swift
//  EthereumWallet
//
//  Created by Sharon Varghese on 25/03/2024.
//

import Foundation
struct GetBalanceResponse: Codable {
    let jsonrpc: String?
    let id: Int?
    let result: String?
}
